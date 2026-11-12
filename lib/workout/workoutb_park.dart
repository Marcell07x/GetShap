import 'dart:math';

import "package:shared_preferences/shared_preferences.dart";
import 'package:getshap/workout/exercises.dart';

/// Turns workout B into the park workout: the pull exercises come from the
/// park ladder below, everything else stays the home workout's.
///
/// The ladder is one path for everyone, and the park level (parkLevel) says
/// where the user stands on it. The pull test only decides where they start:
/// when it ends, the park level is set to the entry of the pull level reached
/// (pullLvl, which never changes after the test). From there every finished
/// park workout moves the park level on, as it moves the level. A home
/// workout leaves it alone.
class WorkoutBPark {
    /// Where each pull level starts on the ladder.
    static const Map<int, int> entry = {1: 0, 2: 80, 3: 240, 4: 320};

    /// The pull exercises (name keys) of a park workout with [slots] pull
    /// slots, at [parkLevel].
    ///
    /// A stage names what stands at the front, in order, and the row that
    /// fills the rest. A negative or a pull-up never takes one of the last
    /// two pull slots: those are always rows.
    static List<String> pulls(int parkLevel, int slots) {
        const String chest = 'chestBwPull';
        const String waist = 'waistBwPull';
        const String neg = 'negPullUp';
        const String pullUp = 'pullUp';
        const String monkey = 'monkeyBarRows';
        const Set<String> rows = {chest, waist, monkey};

        List<String> front;
        String rest;

        if (parkLevel < 40) {
            front = [];
            rest = chest;
        } else if (parkLevel < 80) {
            front = [waist];
            rest = chest;
        } else if (parkLevel < 120) {
            front = [waist, waist];
            rest = chest;
        } else if (parkLevel < 160) {
            front = [waist, waist, waist];
            rest = chest;
        } else if (parkLevel < 200) {
            front = [];
            rest = waist;
        } else if (parkLevel < 240) {
            front = [neg];
            rest = waist;
        } else if (parkLevel < 280) {
            front = [neg, neg];
            rest = waist;
        } else if (parkLevel < 320) {
            front = [pullUp, neg, neg];
            rest = waist;
        } else if (parkLevel < 360) {
            front = [pullUp, pullUp, neg];
            rest = waist;
        } else if (parkLevel < 400) {
            front = [pullUp, pullUp, pullUp];
            rest = waist;
        } else {
            front = [pullUp, pullUp, pullUp];
            rest = monkey;
        }

        return <String>[
            for (int i = 0; i < slots; i++)
                if (i < front.length && (rows.contains(front[i]) || i < slots - 2))
                    front[i]
                else
                    rest,
        ];
    }

    /// The pull exercise called [nameKey], with its reps still to be set.
    static Map<String, String> exercise(String nameKey) => {
        ...Exercises().pull.values.firstWhere((exercise) => exercise['nameKey'] == nameKey),
    };

    /// Workout indices of the pull slots, in order.
    static List<int> pullSlots(List<Map<String, String>> workout) {
        final Set<String?> pullKeys =
            Exercises().pull.values.map((exercise) => exercise['nameKey']).toSet();
        return <int>[
            for (int i = 0; i < workout.length; i++)
                if (pullKeys.contains(workout[i]['nameKey'])) i,
        ];
    }

    /// Whether the user is on the ladder: they train in a park (placeSwitch 1)
    /// and the pull test is over. While the test is on, it supplies the pull
    /// slots itself (pull_test.dart).
    static bool onLadder(SharedPreferences prefs) =>
        (prefs.getInt('placeSwitch') ?? 0) == 1 && (prefs.getBool('pullTestDone') ?? false);

    /// On the ladder, every pull slot of [workout] gets its exercise from it.
    /// The reps come after, from WorkoutBRepsPark.
    static Future<void> parkify(List<Map<String, String>> workout) async {
        final prefs = await SharedPreferences.getInstance();
        if (!onLadder(prefs)) return;

        final List<int> slots = pullSlots(workout);
        final List<String> ladder = pulls(prefs.getInt('parkLevel') ?? 0, slots.length);
        for (int slot = 0; slot < slots.length; slot++) {
            workout[slots[slot]] = exercise(ladder[slot]);
        }
    }

    /// Moves the park level by [by] after a park workout: on by incspeed when
    /// the workout is finished, and with the level when the feedback moves
    /// that. It does not go below 0, and a home workout leaves it alone.
    static Future<void> move(int by) async {
        final prefs = await SharedPreferences.getInstance();
        if (!onLadder(prefs)) return;
        await prefs.setInt('parkLevel', max(0, (prefs.getInt('parkLevel') ?? 0) + by));
    }
}
