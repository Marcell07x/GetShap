// The park pull test: which pull slots are tests, which exercise every pull
// slot gets, and what each saved result writes. Then when the home-or-park
// question is due, and who skips it.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:getshap/workout/exercises.dart';
import 'package:getshap/workout/pull_test.dart';
import 'package:getshap/workout/workout_place_page.dart';
import 'package:getshap/workout/workoutb_park.dart';
import 'package:getshap/workout/workoutb_reps_park.dart';

void main() {
    final Exercises exercises = Exercises();

    /// A workout B of [rounds] rounds of push, pull and legs. Level 150-189
    /// has three, so the pull slots are 1, 4 and 7.
    List<Map<String, String>> workoutB({int rounds = 3}) => <Map<String, String>>[
        for (int block = 0; block < rounds; block++) ...<Map<String, String>>[
            {...exercises.push[3]!, 'reps': '15'},
            {...exercises.pull[1]!, 'reps': '10-15'},
            {...exercises.legs[1]!, 'reps': '10'},
        ],
    ];

    Future<PullTest?> start(Map<String, Object> prefs, {int rounds = 3}) {
        SharedPreferences.setMockInitialValues(prefs);
        return PullTest.start(workoutB(rounds: rounds));
    }

    String? nameAt(PullTest pullTest, int index) =>
        pullTest.exerciseAt(index)?['nameKey'];

    /// What a pull slot that is not a test gets: what the park ladder has on
    /// pull slot [slot] of [slots], where pull level [lvl] enters it.
    String ladderAt(int lvl, int slot, {int slots = 3}) =>
        WorkoutBPark.pulls(WorkoutBPark.entry[lvl]!, slots)[slot];

    group('PullTest', () {
        test('home, no answer yet and a finished test leave the workout alone', () async {
            expect(await start(<String, Object>{'placeSwitch': 0}), isNull);
            expect(await start(<String, Object>{}), isNull);
            expect(await start(<String, Object>{'placeSwitch': 1, 'pullTestDone': true}), isNull);
        });

        test('14 chest-high rows: level 1, over and on the ladder, saved at once', () async {
            final PullTest pullTest = (await start(<String, Object>{'placeSwitch': 1}))!;
            expect(pullTest.exerciseAt(0), isNull);
            expect(pullTest.isTestAt(1), isTrue);
            expect(nameAt(pullTest, 1), 'chestBwPull');

            await pullTest.record(1, 14);
            expect(pullTest.isTestAt(4), isFalse);
            expect(nameAt(pullTest, 4), ladderAt(1, 1));
            expect(
                pullTest.exerciseAt(4)!['reps'],
                WorkoutBRepsPark.reps(ladderAt(1, 1), WorkoutBPark.entry[1]!),
            );
            expect(nameAt(pullTest, 7), ladderAt(1, 2));

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 1);
            expect(prefs.getBool('pullTestDone'), isTrue);
            // The user stays in the park, where level 1 enters the ladder.
            expect(prefs.getInt('placeSwitch'), 1);
            expect(prefs.getInt('parkLevel'), WorkoutBPark.entry[1]);
            expect(prefs.getInt('pullUpMax'), isNull);
        });

        test('15 is saved before the second test comes', () async {
            final PullTest pullTest = (await start(<String, Object>{'placeSwitch': 1}))!;
            await pullTest.record(1, 15);

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 2);
            expect(prefs.getBool('pullTestDone'), isNull);
            expect(prefs.getInt('placeSwitch'), 1);
            // No park level until the test is over.
            expect(prefs.getInt('parkLevel'), isNull);
        });

        test('15, then 14 waist-high rows: level 2, over', () async {
            final PullTest pullTest = (await start(<String, Object>{'placeSwitch': 1}))!;
            await pullTest.record(1, 15);
            expect(pullTest.isTestAt(4), isTrue);
            expect(nameAt(pullTest, 4), 'waistBwPull');

            await pullTest.record(4, 14);
            expect(pullTest.isTestAt(7), isFalse);
            expect(nameAt(pullTest, 7), ladderAt(2, 2));

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 2);
            expect(prefs.getBool('pullTestDone'), isTrue);
            expect(prefs.getInt('placeSwitch'), 1);
            expect(prefs.getInt('parkLevel'), WorkoutBPark.entry[2]);
        });

        test('15 and 15: level 3, and the test carries on next time', () async {
            final PullTest pullTest = (await start(<String, Object>{'placeSwitch': 1}))!;
            await pullTest.record(1, 15);
            await pullTest.record(4, 15);
            // Two tests a workout at most: the third pull slot is a plain one.
            expect(pullTest.isTestAt(7), isFalse);
            expect(nameAt(pullTest, 7), ladderAt(3, 2));
            expect(
                pullTest.exerciseAt(7)!['reps'],
                WorkoutBRepsPark.reps(ladderAt(3, 2), WorkoutBPark.entry[3]!),
            );

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 3);
            expect(prefs.getBool('pullTestDone'), isNull);
            expect(prefs.getInt('placeSwitch'), 1);
            expect(prefs.getInt('parkLevel'), isNull);
        });

        test('from level 3: 10 negatives, then 6 pull-ups saved, over', () async {
            final PullTest pullTest =
                (await start(<String, Object>{'placeSwitch': 1, 'pullLvl': 3}))!;
            expect(nameAt(pullTest, 1), 'negPullUp');
            await pullTest.record(1, 10);
            expect(pullTest.isTestAt(4), isTrue);
            expect(nameAt(pullTest, 4), 'pullUp');

            await pullTest.record(4, 6);
            expect(pullTest.isTestAt(7), isFalse);
            expect(nameAt(pullTest, 7), ladderAt(4, 2));

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 4);
            expect(prefs.getInt('pullUpMax'), 6);
            expect(prefs.getBool('pullTestDone'), isTrue);
            expect(prefs.getInt('placeSwitch'), 1);
            expect(prefs.getInt('parkLevel'), WorkoutBPark.entry[4]);
        });

        test('from level 3: 9 negatives end the test', () async {
            final PullTest pullTest =
                (await start(<String, Object>{'placeSwitch': 1, 'pullLvl': 3}))!;
            await pullTest.record(1, 9);
            expect(pullTest.isTestAt(4), isFalse);
            expect(nameAt(pullTest, 4), ladderAt(3, 1));

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 3);
            expect(prefs.getBool('pullTestDone'), isTrue);
            expect(prefs.getInt('parkLevel'), WorkoutBPark.entry[3]);
        });

        test('from level 3: 10 negatives, then 5 pull-ups: back on level 3, over', () async {
            final PullTest pullTest =
                (await start(<String, Object>{'placeSwitch': 1, 'pullLvl': 3}))!;
            await pullTest.record(1, 10);
            expect(pullTest.isTestAt(4), isTrue);
            expect(nameAt(pullTest, 4), 'pullUp');

            await pullTest.record(4, 5);
            // On the way back the pull-ups are still a test, with their number.
            expect(pullTest.isTestAt(4), isTrue);
            expect(pullTest.repsAt(4), 5);
            expect(pullTest.isTestAt(7), isFalse);
            expect(nameAt(pullTest, 7), ladderAt(3, 2));

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 3);
            // The number is kept: the test is never taken again.
            expect(prefs.getInt('pullUpMax'), 5);
            expect(prefs.getBool('pullTestDone'), isTrue);
            expect(prefs.getInt('placeSwitch'), 1);
            expect(prefs.getInt('parkLevel'), WorkoutBPark.entry[3]);
        });

        test('the app is closed after 10 negatives: the pull-ups come first next time', () async {
            final PullTest closed =
                (await start(<String, Object>{'placeSwitch': 1, 'pullLvl': 3}))!;
            await closed.record(1, 10);

            // Level 4 is not kept yet: the test is still on.
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 4);
            expect(prefs.getBool('pullTestDone'), isNull);
            expect(prefs.getInt('parkLevel'), isNull);

            final PullTest again = (await PullTest.start(workoutB()))!;
            expect(again.isTestAt(1), isTrue);
            expect(nameAt(again, 1), 'pullUp');

            await again.record(1, 5);
            expect(again.isTestAt(4), isFalse);
            expect(nameAt(again, 4), ladderAt(3, 1));
            expect(
                again.exerciseAt(4)!['reps'],
                WorkoutBRepsPark.reps(ladderAt(3, 1), WorkoutBPark.entry[3]!),
            );

            expect(prefs.getInt('pullLvl'), 3);
            expect(prefs.getBool('pullTestDone'), isTrue);
            expect(prefs.getInt('parkLevel'), WorkoutBPark.entry[3]);
        });

        test('from level 4, four pull slots: 5 pull-ups put the user back on level 3', () async {
            final PullTest pullTest =
                (await start(<String, Object>{'placeSwitch': 1, 'pullLvl': 4}, rounds: 4))!;
            expect(nameAt(pullTest, 1), 'pullUp');
            await pullTest.record(1, 5);

            // The rest of the workout is what level 3 enters the ladder on,
            // not level 4: no second set of pull-ups.
            expect(pullTest.isTestAt(4), isFalse);
            expect(nameAt(pullTest, 4), ladderAt(3, 1, slots: 4));
            expect(nameAt(pullTest, 4), isNot('pullUp'));
            expect(nameAt(pullTest, 7), ladderAt(3, 2, slots: 4));
            expect(nameAt(pullTest, 10), ladderAt(3, 3, slots: 4));

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 3);
            expect(prefs.getInt('pullUpMax'), 5);
            expect(prefs.getBool('pullTestDone'), isTrue);
            expect(prefs.getInt('parkLevel'), WorkoutBPark.entry[3]);
        });

        test('from level 4, four pull slots: the pull-up set after the test gets the reps of the ladder', () async {
            final PullTest pullTest =
                (await start(<String, Object>{'placeSwitch': 1, 'pullLvl': 4}, rounds: 4))!;
            expect(nameAt(pullTest, 1), 'pullUp');
            await pullTest.record(1, 6);

            // The test is over, and level 4 enters the ladder on two sets of
            // pull-ups: the second one gets the reps the ladder has there,
            // whatever the number just entered.
            expect(pullTest.isTestAt(4), isFalse);
            expect(nameAt(pullTest, 4), 'pullUp');
            expect(
                pullTest.exerciseAt(4)!['reps'],
                WorkoutBRepsPark.reps('pullUp', WorkoutBPark.entry[4]!),
            );
            expect(nameAt(pullTest, 7), ladderAt(4, 2, slots: 4));
            expect(nameAt(pullTest, 10), ladderAt(4, 3, slots: 4));
        });

        test('from level 4, three pull slots: the second slot is pull-ups too', () async {
            final PullTest pullTest =
                (await start(<String, Object>{'placeSwitch': 1, 'pullLvl': 4}))!;
            await pullTest.record(1, 6);

            // With three pull slots only the last one is kept for a row, so
            // the second set of pull-ups fits in as well.
            expect(pullTest.isTestAt(4), isFalse);
            expect(nameAt(pullTest, 4), 'pullUp');
            expect(
                pullTest.exerciseAt(4)!['reps'],
                WorkoutBRepsPark.reps('pullUp', WorkoutBPark.entry[4]!),
            );
            expect(nameAt(pullTest, 7), 'waistBwPull');
        });

        test('a saved result cannot be changed on the way back', () async {
            final PullTest pullTest = (await start(<String, Object>{'placeSwitch': 1}))!;
            await pullTest.record(1, 15);
            await pullTest.record(4, 15);

            await pullTest.record(1, 5);
            expect(pullTest.repsAt(1), 15);
            expect(pullTest.isTestAt(4), isTrue);
            expect(nameAt(pullTest, 7), ladderAt(3, 2));

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 3);
            expect(prefs.getBool('pullTestDone'), isNull);
        });

        test('an abandoned workout picks the test up where it stopped', () async {
            final PullTest abandoned = (await start(<String, Object>{'placeSwitch': 1}))!;
            await abandoned.record(1, 15);

            // The workout is closed before Finish and started again.
            final PullTest again = (await PullTest.start(workoutB()))!;
            expect(again.isTestAt(1), isTrue);
            expect(nameAt(again, 1), 'waistBwPull');
            expect(again.repsAt(1), isNull);
        });
    });

    group('placeQuestionDue', () {
        Future<bool> due(Map<String, Object> prefs) {
            SharedPreferences.setMockInitialValues(prefs);
            return placeQuestionDue();
        }

        test('not before level 150', () async {
            expect(await due(<String, Object>{'level': 149, 'age': 2}), isFalse);
        });

        test('from level 150 for someone under 60', () async {
            expect(await due(<String, Object>{'level': 150, 'age': 2, 'previous_exp_1': false}), isTrue);
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getBool('placeQuestionAnswered'), isNull);
        });

        test('60+ without past sport: skipped and counted as answered, home kept', () async {
            expect(await due(<String, Object>{'level': 150, 'age': 3, 'previous_exp_1': false}), isFalse);
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getBool('placeQuestionAnswered'), isTrue);
            expect(prefs.getInt('placeSwitch'), isNull);
        });

        test('60+ who used to play sports regularly is asked', () async {
            expect(await due(<String, Object>{'level': 150, 'age': 3, 'previous_exp_1': true}), isTrue);
        });

        test('only until it is answered', () async {
            expect(await due(<String, Object>{'level': 200, 'age': 1, 'placeQuestionAnswered': true}), isFalse);
        });
    });
}
