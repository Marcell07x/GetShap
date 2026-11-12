import "package:shared_preferences/shared_preferences.dart";
import 'package:getshap/workout/exercises.dart';
import 'package:getshap/workout/workoutb_park.dart';
import 'package:getshap/workout/workoutb_reps_park.dart';

/// The pull test of a park workout. It sets the park pull level (pullLvl):
/// 1 chest-high row, 2 waist-high row, 3 negative pull-up, 4 pull-up.
///
/// While the test is on, the first two pull slots of the workout are tests:
/// the user does as many reps as they can and enters the number. Reaching the
/// level's target moves them up a level, and the next slot tests that one;
/// falling short ends the test. Level 4 has no target: the pull-ups are saved
/// as pullUpMax, and the test is over. Two tests a workout at most, so someone
/// who passes both carries on in the next park workout. The other pull slots
/// get what the park ladder (workoutb_park.dart) has where the level reached
/// so far enters it.
///
/// When the test is over, the user's park level (parkLevel) starts from the
/// entry of their pull level, and the pull level never changes again.
///
/// Every result is saved the moment it is entered, and stays: going back shows
/// it but cannot change it, and an abandoned workout picks the test up where
/// it stopped.
class PullTest {
    /// The reps that move the user up from a level. Level 4 has no target.
    static const Map<int, int> _targets = {1: 15, 2: 15, 3: 10};
    static const int _testsPerWorkout = 2;

    final Exercises _exercises = Exercises();
    final int _startLvl;

    /// Workout indices of the pull slots, in order.
    final List<int> _pullSlots;

    /// The reps entered on the tests, by pull slot number.
    final Map<int, int> _reps = {};

    PullTest._(this._startLvl, this._pullSlots);

    /// Null unless the user trains in a park (placeSwitch 1) and the test is
    /// not over yet.
    static Future<PullTest?> start(List<Map<String, String>> workout) async {
        final prefs = await SharedPreferences.getInstance();
        if ((prefs.getInt('placeSwitch') ?? 0) != 1 ||
            (prefs.getBool('pullTestDone') ?? false)) {
            return null;
        }

        final int startLvl = (prefs.getInt('pullLvl') ?? 1).clamp(1, 4);
        return PullTest._(startLvl, WorkoutBPark.pullSlots(workout));
    }

    /// Where the test stands before pull slot [slot]: the level reached,
    /// whether the test is over, and the pull-ups entered on level 4.
    ({int lvl, bool over, int? pullUpMax}) _before(int slot) {
        int lvl = _startLvl;
        for (int i = 0; i < slot && i < _testsPerWorkout; i++) {
            final int? reps = _reps[i];
            if (reps == null) break;
            if (lvl == 4) return (lvl: lvl, over: true, pullUpMax: reps);
            if (reps < _targets[lvl]!) return (lvl: lvl, over: true, pullUpMax: null);
            lvl++;
        }
        return (lvl: lvl, over: false, pullUpMax: null);
    }

    int? _slotAt(int index) {
        final int slot = _pullSlots.indexOf(index);
        return slot < 0 ? null : slot;
    }

    /// Whether workout index [index] is a test.
    bool isTestAt(int index) {
        final int? slot = _slotAt(index);
        return slot != null && slot < _testsPerWorkout && !_before(slot).over;
    }

    /// The exercise for workout index [index], or null when it is not a pull
    /// slot. A test is on the exercise of the level it tests. Every other
    /// pull slot gets what the park ladder has at that slot where the level
    /// reached so far enters it, with the park reps.
    Map<String, String>? exerciseAt(int index) {
        final int? slot = _slotAt(index);
        if (slot == null) return null;
        final state = _before(slot);
        if (isTestAt(index)) return {..._exercises.pull[state.lvl + 2]!};

        final int parkLevel = WorkoutBPark.entry[state.lvl]!;
        final String nameKey = WorkoutBPark.pulls(parkLevel, _pullSlots.length)[slot];
        return {
            ...WorkoutBPark.exercise(nameKey),
            'reps': WorkoutBRepsPark.reps(nameKey, parkLevel, state.lvl, state.pullUpMax ?? 0),
        };
    }

    /// The saved result of the test at [index], shown locked on the way back.
    int? repsAt(int index) {
        final int? slot = _slotAt(index);
        return slot == null ? null : _reps[slot];
    }

    /// Saves a test result the moment it is entered. Only the first number
    /// counts: a saved result cannot be changed.
    Future<void> record(int index, int reps) async {
        final int? slot = _slotAt(index);
        if (slot == null || _reps.containsKey(slot)) return;
        _reps[slot] = reps;
        await _save();
    }

    /// Once the test is over, the user is on the park ladder, where their
    /// pull level enters it.
    Future<void> _save() async {
        final prefs = await SharedPreferences.getInstance();
        final result = _before(_pullSlots.length);
        await prefs.setInt('pullLvl', result.lvl);
        if (result.pullUpMax != null) {
            await prefs.setInt('pullUpMax', result.pullUpMax!);
        }
        if (result.over) {
            await prefs.setBool('pullTestDone', true);
            await prefs.setInt('parkLevel', WorkoutBPark.entry[result.lvl]!);
        }
    }
}
