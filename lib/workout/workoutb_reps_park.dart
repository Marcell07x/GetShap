import "package:shared_preferences/shared_preferences.dart";
import 'package:getshap/workout/workoutb_park.dart';

/// The reps of the pull slots of a park workout, to go with the exercises
/// WorkoutBPark put there.
class WorkoutBRepsPark {
    /// The reps of the park pull called [nameKey] at [parkLevel]. They depend
    /// on the park level only: everyone gets the same range, and the pull-ups
    /// done on the pull test do not count.
    ///
    /// Past 400 the exercises stay, and the pull-ups and the monkey bar rows
    /// get more reps instead, up to 720. That is where someone who entered
    /// the ladder at the top (pull level 4, at 320) gets by level 550, where
    /// the home workout changes for the last time.
    static String reps(String nameKey, int parkLevel) {
        if (nameKey == 'negPullUp') return '4-7';

        if (nameKey == 'monkeyBarRows') {
            if (parkLevel < 480) {
                return '8-12';
            } else if (parkLevel < 560) {
                return '10-14';
            } else if (parkLevel < 640) {
                return '12-16';
            } else if (parkLevel < 720) {
                return '14-18';
            } else {
                return '16-20';
            }
        }

        //the chest-high and the waist-high row
        if (nameKey != 'pullUp') return '10-15';

        if (parkLevel < 320) {
            return '1-3';
        } else if (parkLevel < 360) {
            return '2-4';
        } else if (parkLevel < 400) {
            return '3-5';
        } else if (parkLevel < 440) {
            return '4-6';
        } else if (parkLevel < 480) {
            return '5-7';
        } else if (parkLevel < 520) {
            return '6-8';
        } else if (parkLevel < 560) {
            return '7-9';
        } else if (parkLevel < 600) {
            return '8-10';
        } else if (parkLevel < 640) {
            return '8-12';
        } else if (parkLevel < 680) {
            return '9-13';
        } else if (parkLevel < 720) {
            return '10-14';
        } else {
            return '10-15';
        }
    }

    /// On the ladder, the pull slots of [workout] get the park reps. It runs
    /// after the home reps are set, so every other slot keeps those.
    static Future<void> parkify(List<Map<String, String>> workout) async {
        final prefs = await SharedPreferences.getInstance();
        if (!WorkoutBPark.onLadder(prefs)) return;

        final int parkLevel = prefs.getInt('parkLevel') ?? 0;
        for (final int index in WorkoutBPark.pullSlots(workout)) {
            workout[index]['reps'] = reps(workout[index]['nameKey']!, parkLevel);
        }
    }
}
