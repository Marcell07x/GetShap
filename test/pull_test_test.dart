// The park pull test: which pull slots are tests, which exercise every pull
// slot gets, and what each saved result writes. Then when the home-or-park
// question is due, and who skips it.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:getshap/workout/exercises.dart';
import 'package:getshap/workout/pull_test.dart';
import 'package:getshap/workout/workout_place_page.dart';

void main() {
    final Exercises exercises = Exercises();

    /// A level 150-189 workout B: push, pull and legs three times over, so the
    /// pull slots are 1, 4 and 7.
    List<Map<String, String>> workoutB() => <Map<String, String>>[
        for (int block = 0; block < 3; block++) ...<Map<String, String>>[
            {...exercises.push[3]!, 'reps': '15'},
            {...exercises.pull[1]!, 'reps': '10-15'},
            {...exercises.legs[1]!, 'reps': '10'},
        ],
    ];

    Future<PullTest?> start(Map<String, Object> prefs) {
        SharedPreferences.setMockInitialValues(prefs);
        return PullTest.start(workoutB());
    }

    String? nameAt(PullTest pullTest, int index) =>
        pullTest.exerciseAt(index)?['nameKey'];

    group('PullTest', () {
        test('home, no answer yet and a finished test leave the workout alone', () async {
            expect(await start(<String, Object>{'placeSwitch': 0}), isNull);
            expect(await start(<String, Object>{}), isNull);
            expect(await start(<String, Object>{'placeSwitch': 1, 'pullTestDone': true}), isNull);
        });

        test('14 chest-high rows: level 1, over and back to home, saved at once', () async {
            final PullTest pullTest = (await start(<String, Object>{'placeSwitch': 1}))!;
            expect(pullTest.exerciseAt(0), isNull);
            expect(pullTest.isTestAt(1), isTrue);
            expect(nameAt(pullTest, 1), 'chestBwPull');

            await pullTest.record(1, 14);
            expect(pullTest.isTestAt(4), isFalse);
            expect(nameAt(pullTest, 4), 'chestBwPull');
            expect(pullTest.exerciseAt(4)!['reps'], '10-15');
            expect(nameAt(pullTest, 7), 'chestBwPull');

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 1);
            expect(prefs.getBool('pullTestDone'), isTrue);
            expect(prefs.getInt('placeSwitch'), 0);
            expect(prefs.getInt('pullUpMax'), isNull);
        });

        test('15 is saved before the second test comes', () async {
            final PullTest pullTest = (await start(<String, Object>{'placeSwitch': 1}))!;
            await pullTest.record(1, 15);

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 2);
            expect(prefs.getBool('pullTestDone'), isNull);
            expect(prefs.getInt('placeSwitch'), 1);
        });

        test('15, then 14 waist-high rows: level 2, over', () async {
            final PullTest pullTest = (await start(<String, Object>{'placeSwitch': 1}))!;
            await pullTest.record(1, 15);
            expect(pullTest.isTestAt(4), isTrue);
            expect(nameAt(pullTest, 4), 'waistBwPull');

            await pullTest.record(4, 14);
            expect(pullTest.isTestAt(7), isFalse);
            expect(nameAt(pullTest, 7), 'waistBwPull');

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 2);
            expect(prefs.getBool('pullTestDone'), isTrue);
            expect(prefs.getInt('placeSwitch'), 0);
        });

        test('15 and 15: level 3, and the test carries on next time', () async {
            final PullTest pullTest = (await start(<String, Object>{'placeSwitch': 1}))!;
            await pullTest.record(1, 15);
            await pullTest.record(4, 15);
            // Two tests a workout at most: the third pull slot is a plain one.
            expect(pullTest.isTestAt(7), isFalse);
            expect(nameAt(pullTest, 7), 'negPullUp');
            expect(pullTest.exerciseAt(7)!['reps'], '10-15');

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 3);
            expect(prefs.getBool('pullTestDone'), isNull);
            expect(prefs.getInt('placeSwitch'), 1);
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
            expect(nameAt(pullTest, 7), 'pullUp');

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 4);
            expect(prefs.getInt('pullUpMax'), 6);
            expect(prefs.getBool('pullTestDone'), isTrue);
            expect(prefs.getInt('placeSwitch'), 0);
        });

        test('from level 3: 9 negatives end the test', () async {
            final PullTest pullTest =
                (await start(<String, Object>{'placeSwitch': 1, 'pullLvl': 3}))!;
            await pullTest.record(1, 9);
            expect(pullTest.isTestAt(4), isFalse);
            expect(nameAt(pullTest, 4), 'negPullUp');

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            expect(prefs.getInt('pullLvl'), 3);
            expect(prefs.getBool('pullTestDone'), isTrue);
        });

        test('a saved result cannot be changed on the way back', () async {
            final PullTest pullTest = (await start(<String, Object>{'placeSwitch': 1}))!;
            await pullTest.record(1, 15);
            await pullTest.record(4, 15);

            await pullTest.record(1, 5);
            expect(pullTest.repsAt(1), 15);
            expect(pullTest.isTestAt(4), isTrue);
            expect(nameAt(pullTest, 7), 'negPullUp');

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
