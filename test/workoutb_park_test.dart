// The park workout: what the park ladder puts on the pull slots, the reps that
// go with it, how workout B is turned into a park workout, and what moves the
// park level.
//
// The stages' own numbers are left to workoutb_park.dart and
// workoutb_reps_park.dart, so that they can be tuned there. These tests hold
// the rules: where each pull level enters the ladder, and what never happens.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:getshap/workout/exercises.dart';
import 'package:getshap/workout/feedback_execution.dart';
import 'package:getshap/workout/workoutb.dart';
import 'package:getshap/workout/workoutb_park.dart';
import 'package:getshap/workout/workoutb_reps.dart';
import 'package:getshap/workout/workoutb_reps_park.dart';

void main() {
    const String chest = 'chestBwPull';
    const String waist = 'waistBwPull';
    const String neg = 'negPullUp';
    const String pullUp = 'pullUp';
    const String monkey = 'monkeyBarRows';
    const Set<String> rows = <String>{chest, waist, monkey};

    /// Park levels all along the ladder, and well past its last stage.
    final List<int> parkLevels = <int>[for (int level = 0; level <= 600; level += 5) level];

    /// The first park workout's pulls of someone the test put on [pullLvl].
    List<String> entryOf(int pullLvl, int slots) =>
        WorkoutBPark.pulls(WorkoutBPark.entry[pullLvl]!, slots);

    group('the park ladder', () {
        test('pull level 1 starts on chest-high rows only', () {
            expect(entryOf(1, 3), <String>[chest, chest, chest]);
            expect(entryOf(1, 5), <String>[chest, chest, chest, chest, chest]);
        });

        test('pull level 2 starts on two waist-high rows, then chest-high ones', () {
            expect(entryOf(2, 3), <String>[waist, waist, chest]);
            expect(entryOf(2, 4), <String>[waist, waist, chest, chest]);
        });

        test('pull level 3 starts on two negatives, with three pull slots too', () {
            expect(entryOf(3, 4), <String>[neg, neg, waist, waist]);
            expect(entryOf(3, 3), <String>[neg, neg, waist]);
        });

        test('pull level 4 starts on two sets of pull-ups, with three pull slots too', () {
            expect(entryOf(4, 4), <String>[pullUp, pullUp, waist, waist]);
            expect(entryOf(4, 3), <String>[pullUp, pullUp, waist]);
        });

        test('a higher pull level starts further on', () {
            for (int pullLvl = 1; pullLvl < 4; pullLvl++) {
                expect(WorkoutBPark.entry[pullLvl]!, lessThan(WorkoutBPark.entry[pullLvl + 1]!));
            }
        });

        test('the first pull-up set comes at the front, before the negatives', () {
            final int first = parkLevels.firstWhere(
                (int level) => WorkoutBPark.pulls(level, 5).contains(pullUp),
            );
            expect(WorkoutBPark.pulls(first, 5), <String>[pullUp, neg, neg, waist, waist]);
            expect(WorkoutBPark.pulls(first, 4), <String>[pullUp, neg, waist, waist]);
            expect(WorkoutBPark.pulls(first, 3), <String>[pullUp, neg, waist]);
        });

        test('the last two pull slots are always rows, the last one with three', () {
            for (final int level in parkLevels) {
                for (int slots = 3; slots <= 5; slots++) {
                    final int tail = slots >= 4 ? 2 : 1;
                    final List<String> pulls = WorkoutBPark.pulls(level, slots);
                    expect(
                        rows.containsAll(pulls.sublist(slots - tail)),
                        isTrue,
                        reason: 'park level $level, $slots pull slots: $pulls',
                    );
                }
            }
        });

        test('every stage fills every pull slot with a pull exercise', () {
            final Set<String?> pullKeys =
                Exercises().pull.values.map((exercise) => exercise['nameKey']).toSet();
            for (final int level in parkLevels) {
                for (int slots = 3; slots <= 5; slots++) {
                    final List<String> pulls = WorkoutBPark.pulls(level, slots);
                    expect(pulls, hasLength(slots));
                    expect(pullKeys.containsAll(pulls), isTrue, reason: 'park level $level: $pulls');
                }
            }
        });

        test('it ends on monkey bar rows behind the pull-ups', () {
            expect(WorkoutBPark.pulls(parkLevels.last, 5), <String>[pullUp, pullUp, pullUp, monkey, monkey]);
        });
    });

    group('the park reps', () {
        test('rows and negatives are the same for everyone', () {
            for (final String nameKey in <String>[chest, waist, monkey, neg]) {
                expect(WorkoutBRepsPark.reps(nameKey, 0, 1, 0), WorkoutBRepsPark.reps(nameKey, 500, 4, 12));
                expect(WorkoutBRepsPark.reps(nameKey, 0, 1, 0), isNotEmpty);
            }
        });

        test('pull level 4 starts on max - 2 pull-ups, at least 1', () {
            final int entry = WorkoutBPark.entry[4]!;
            expect(WorkoutBRepsPark.reps(pullUp, entry, 4, 8), '6');
            expect(WorkoutBRepsPark.reps(pullUp, entry, 4, 3), '1');
            expect(WorkoutBRepsPark.reps(pullUp, entry, 4, 2), '1');
            expect(WorkoutBRepsPark.reps(pullUp, entry, 4, 0), '1');
        });

        test('pull level 4 never gets fewer pull-ups further on', () {
            int before = 0;
            for (final int level in parkLevels) {
                final int reps = int.parse(WorkoutBRepsPark.reps(pullUp, level, 4, 8));
                expect(reps, greaterThanOrEqualTo(before), reason: 'park level $level');
                before = reps;
            }
        });

        test('below pull level 4 the pull-ups are a fixed range, whatever the max', () {
            for (final int level in parkLevels) {
                for (int pullLvl = 1; pullLvl <= 3; pullLvl++) {
                    final String reps = WorkoutBRepsPark.reps(pullUp, level, pullLvl, 0);
                    expect(reps, matches(RegExp(r'^\d+-\d+$')), reason: 'park level $level');
                    expect(WorkoutBRepsPark.reps(pullUp, level, pullLvl, 20), reps);
                }
            }
        });
    });

    /// Workout B with its reps, as the workout builds it, for [prefs].
    Future<List<Map<String, String>>> workoutB(Map<String, Object> prefs) async {
        SharedPreferences.setMockInitialValues(<String, Object>{
            'pushe': 2,
            'pulle': 1,
            'legse': 1,
            'switch': 1,
            'coreSwitch': 1,
            'age': 1,
            ...prefs,
        });
        final WorkoutB workout = WorkoutB();
        await workout.SetExerB();
        await WorkoutBReps().SetRepsB(workout.workout_partsB);
        return workout.workout_partsB;
    }

    group('workout B in a park', () {
        /// Someone on the ladder, where the first pull-up has just come.
        const Map<String, Object> onLadder = <String, Object>{
            'placeSwitch': 1,
            'pullTestDone': true,
            'pullLvl': 3,
            'parkLevel': 280,
        };

        /// The levels where the number of pull slots changes, and that number.
        const Map<int, int> pullSlotsAt = <int, int>{150: 3, 350: 4, 430: 4, 550: 5};

        test('only the pull slots change, to the ladder and its reps', () async {
            for (final MapEntry<int, int> at in pullSlotsAt.entries) {
                final List<Map<String, String>> home =
                    await workoutB(<String, Object>{'level': at.key});
                final List<Map<String, String>> park =
                    await workoutB(<String, Object>{'level': at.key, ...onLadder});

                final List<int> slots = WorkoutBPark.pullSlots(home);
                expect(slots, hasLength(at.value), reason: 'level ${at.key}');
                expect(WorkoutBPark.pullSlots(park), slots);

                final List<String> ladder = WorkoutBPark.pulls(280, at.value);
                for (int i = 0; i < home.length; i++) {
                    final int slot = slots.indexOf(i);
                    if (slot < 0) {
                        expect(park[i], home[i], reason: 'level ${at.key}, part $i');
                        continue;
                    }
                    expect(park[i]['nameKey'], ladder[slot], reason: 'level ${at.key}, part $i');
                    expect(park[i]['reps'], WorkoutBRepsPark.reps(ladder[slot], 280, 3, 0));
                }
            }
        });

        test('at home it is the home workout, whatever the park level', () async {
            for (final int level in pullSlotsAt.keys) {
                final List<Map<String, String>> home =
                    await workoutB(<String, Object>{'level': level});
                final List<Map<String, String>> backHome =
                    await workoutB(<String, Object>{'level': level, ...onLadder, 'placeSwitch': 0});
                expect(backHome, home, reason: 'level $level');
            }
        });

        test('while the pull test is on, the pull slots are left to it', () async {
            final List<Map<String, String>> home = await workoutB(<String, Object>{'level': 150});
            final List<Map<String, String>> testing =
                await workoutB(<String, Object>{'level': 150, 'placeSwitch': 1});
            expect(testing, home);
        });

        test('someone who did pull-ups on the test gets them counted from that max', () async {
            final List<Map<String, String>> park = await workoutB(<String, Object>{
                'level': 350,
                'placeSwitch': 1,
                'pullTestDone': true,
                'pullLvl': 4,
                'pullUpMax': 9,
                'parkLevel': WorkoutBPark.entry[4]!,
            });
            final List<int> slots = WorkoutBPark.pullSlots(park);
            expect(park[slots[0]]['nameKey'], pullUp);
            expect(park[slots[0]]['reps'], '7');
            expect(park[slots[1]]['reps'], '7');
        });
    });

    group('the park level', () {
        const Map<String, Object> onLadder = <String, Object>{
            'placeSwitch': 1,
            'pullTestDone': true,
            'parkLevel': 100,
        };

        /// The park level after [action] ran on [prefs].
        Future<int?> after(Map<String, Object> prefs, Future<void> Function() action) async {
            SharedPreferences.setMockInitialValues(prefs);
            await action();
            return (await SharedPreferences.getInstance()).getInt('parkLevel');
        }

        test('a finished park workout moves it on', () async {
            expect(await after(onLadder, () => WorkoutBPark.move(4)), 104);
        });

        test('a home workout leaves it alone', () async {
            expect(
                await after(<String, Object>{...onLadder, 'placeSwitch': 0}, () => WorkoutBPark.move(4)),
                100,
            );
        });

        test('there is none while the pull test is on', () async {
            expect(
                await after(<String, Object>{'placeSwitch': 1}, () => WorkoutBPark.move(4)),
                isNull,
            );
        });

        test('it does not go below 0', () async {
            expect(
                await after(<String, Object>{...onLadder, 'parkLevel': 10}, () => WorkoutBPark.move(-20)),
                0,
            );
        });

        /// The level and the park level after the feedback [rpe] on [prefs].
        Future<(int?, int?)> afterFeedback(Map<String, Object> prefs, int rpe) async {
            final int? parkLevel = await after(
                <String, Object>{'incspeed': 4, ...prefs, 'rpe_value': rpe},
                FeedbackExecution.executeOnFeedback,
            );
            return ((await SharedPreferences.getInstance()).getInt('level'), parkLevel);
        }

        test('after a park workout the feedback moves it with the level', () async {
            const Map<String, Object> at300 = <String, Object>{...onLadder, 'level': 300};
            expect(await afterFeedback(at300, 10), (280, 80));
            expect(await afterFeedback(at300, 9), (290, 90));
            expect(await afterFeedback(at300, 5), (300, 100));
            expect(await afterFeedback(at300, 2), (310, 110));
            expect(await afterFeedback(at300, 1), (320, 120));
            // Just above 150 the level only drops back to 150, and the park
            // level by as much.
            expect(await afterFeedback(<String, Object>{...onLadder, 'level': 154}, 9), (150, 96));
        });

        test('after a home workout the feedback leaves it alone', () async {
            expect(
                await afterFeedback(<String, Object>{...onLadder, 'placeSwitch': 0, 'level': 300}, 10),
                (280, 100),
            );
        });
    });
}
