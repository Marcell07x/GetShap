import 'dart:math';

import "package:shared_preferences/shared_preferences.dart";
import 'package:getshap/workout/workoutb_park.dart';

/// The reps of the pull slots of a park workout, to go with the exercises
/// WorkoutBPark put there.
class WorkoutBRepsPark {
    /// The reps of the park pull called [nameKey] at [parkLevel].
    ///
    /// Someone who did pull-ups on the pull test (pull level 4) gets their
    /// pull-ups counted from that max ([pullUpMax]), at least 1. Everyone
    /// else gets a fixed range.
    static String reps(String nameKey, int parkLevel, int pullLvl, int pullUpMax) {
        if (nameKey == 'negPullUp') return '3-5';
        if (nameKey == 'monkeyBarRows') return '8-12';
        //the chest-high and the waist-high row
        if (nameKey != 'pullUp') return '10-15';

        if (pullLvl == 4) {
            int fromMax;
            if (parkLevel < 400) {
                fromMax = -2;
            } else if (parkLevel < 440) {
                fromMax = -1;
            } else {
                fromMax = 0;
            }
            return max(1, pullUpMax + fromMax).toString();
        }

        if (parkLevel < 320) {
            return '1-3';
        } else if (parkLevel < 360) {
            return '2-4';
        } else if (parkLevel < 400) {
            return '3-5';
        } else {
            return '4-6';
        }
    }

    /// On the ladder, the pull slots of [workout] get the park reps. It runs
    /// after the home reps are set, so every other slot keeps those.
    static Future<void> parkify(List<Map<String, String>> workout) async {
        final prefs = await SharedPreferences.getInstance();
        if (!WorkoutBPark.onLadder(prefs)) return;

        final int parkLevel = prefs.getInt('parkLevel') ?? 0;
        final int pullLvl = prefs.getInt('pullLvl') ?? 1;
        final int pullUpMax = prefs.getInt('pullUpMax') ?? 0;
        for (final int index in WorkoutBPark.pullSlots(workout)) {
            workout[index]['reps'] = reps(workout[index]['nameKey']!, parkLevel, pullLvl, pullUpMax);
        }
    }
}
