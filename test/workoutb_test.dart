// Workout B across its level bands: the exercises (workoutb.dart) and the reps
// (workoutb_reps.dart) are two separate lists per band, and have to stay the
// same length.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:getshap/workout/workoutb.dart';
import 'package:getshap/workout/workoutb_park.dart';
import 'package:getshap/workout/workoutb_reps.dart';

void main() {
    /// Workout B with its reps, as the workout builds it at [level].
    Future<List<Map<String, String>>> workoutB(int level) async {
        SharedPreferences.setMockInitialValues(<String, Object>{
            'level': level,
            'pushe': 2,
            'pulle': 1,
            'legse': 1,
            'switch': 1,
            'coreSwitch': 1,
            'age': 1,
        });
        final WorkoutB workout = WorkoutB();
        await workout.SetExerB();
        await WorkoutBReps().SetRepsB(workout.workout_partsB);
        return workout.workout_partsB;
    }

    test('every part has reps in every level band', () async {
        // The first level of every band of either list, and one far past the last.
        for (final int level in <int>[150, 190, 230, 270, 310, 350, 390, 430, 470, 510, 550, 900]) {
            final List<Map<String, String>> workout = await workoutB(level);
            for (int i = 0; i < workout.length; i++) {
                expect(workout[i]['reps'], isNotEmpty, reason: 'level $level, part $i');
            }
        }
    });

    test('550 brings the fifth round', () async {
        final List<Map<String, String>> before = await workoutB(549);
        final List<Map<String, String>> from = await workoutB(550);

        expect(WorkoutBPark.pullSlots(before), hasLength(4));
        expect(WorkoutBPark.pullSlots(from), hasLength(5));
        // The fifth round is a push, a pull and a leg exercise after the
        // workout as it was.
        expect(from, hasLength(before.length + 3));
        expect(from.sublist(0, before.length), before);
    });
}
