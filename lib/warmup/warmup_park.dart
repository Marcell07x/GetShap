import "package:shared_preferences/shared_preferences.dart";
import 'package:getshap/workout/workoutb_park.dart';

/// The pull of the warm-up of a park workout. The rest of the warm-up is the
/// home one.
class WarmupPark {
    static String pull(int parkLevel) {
        if (parkLevel < 170) {
            return 'chestBwPull';
        } else if (parkLevel < 480) {
            return 'waistBwPull';
        } else {
            return 'monkeyBarRows';
        }
    }

    static String reps(int parkLevel) {
        if (parkLevel < 40) {
            return '8';
        } else {
            return '12';
        }
    }

    /// The pull is the second part of every warm-up (warmup.dart).
    ///
    /// Before the waist-high rows are passed on the pull test, the workout
    /// starts on a row test, so the warm-up has no pull.
    static Future<void> parkify(List<Map<String, String>> warmup) async {
        final prefs = await SharedPreferences.getInstance();
        if ((prefs.getInt('placeSwitch') ?? 0) != 1 || warmup.isEmpty) return;

        final bool testOver = prefs.getBool('pullTestDone') ?? false;
        final bool waistRowsPassed = (prefs.getInt('pullLvl') ?? 1) >= 3;

        if (testOver) {
            final int parkLevel = prefs.getInt('parkLevel') ?? 0;
            warmup[1] = {...WorkoutBPark.exercise(pull(parkLevel)), 'reps': reps(parkLevel)};
        } else if (waistRowsPassed) {
            warmup[1] = {...WorkoutBPark.exercise('waistBwPull'), 'reps': '12'};
        } else {
            warmup.removeAt(1);
        }
    }
}
