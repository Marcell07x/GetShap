// What is downloaded ahead of the next workout (next_workout_videos.dart): the
// videos of the exercises its warm-up and the workout itself will show, and,
// while the park pull test is on, of whatever the test can bring up.
//
// Which exercise comes at which level is left to the workout builders, so that
// they can be tuned there. These tests hold the rule: nothing the user is
// about to see is missing from the download.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:getshap/warmup/warmup.dart';
import 'package:getshap/workout/exercises.dart';
import 'package:getshap/workout/next_workout_videos.dart';
import 'package:getshap/workout/pull_test.dart';
import 'package:getshap/workout/workouta.dart';
import 'package:getshap/workout/workoutb.dart';
import 'package:getshap/workout/workoutb_park.dart';

void main() {
    final Exercises exercises = Exercises();

    /// The saved state of a user at [level], with [more] on top of it.
    void user(int level, [Map<String, Object> more = const <String, Object>{}]) {
        SharedPreferences.setMockInitialValues(<String, Object>{
            'level': level,
            'pushe': 2,
            'pulle': 1,
            'legse': 1,
            'switch': 1,
            'coreSwitch': 1,
            'age': 1,
            ...more,
        });
    }

    /// The videos of [parts], which must not be empty: an empty workout would
    /// make every check below pass on nothing.
    Set<String> videosOf(List<Map<String, String>> parts) {
        expect(parts, isNotEmpty);
        final Set<String> videos = <String>{};
        for (final Map<String, String> part in parts) {
            videos.add(part['videoPath']!);
        }
        return videos;
    }

    test('every exercise\'s video is a bare file name, as it is on the server', () {
        final List<Map<String, String>> all = <Map<String, String>>[
            ...exercises.push.values,
            ...exercises.pull.values,
            ...exercises.legs.values,
            ...exercises.core.values,
            ...exercises.warmUpExer.values,
        ];
        for (final String video in videosOf(all)) {
            expect(video, matches(RegExp(r'^[A-Za-z0-9]+\.mp4$')));
        }
    });

    test('a beginner with one exercise needs one video', () async {
        user(10);
        expect(await nextWorkoutVideos(), <String>{exercises.push[2]!['videoPath']!});
    });

    test('the videos of workout A are all there', () async {
        // The first level of every band of workout A, and the last level of it.
        for (final int level in <int>[1, 30, 60, 85, 90, 95, 110, 115, 125, 135, 149]) {
            user(level);
            final Set<String> videos = await nextWorkoutVideos();

            final WorkoutA workout = WorkoutA();
            await workout.SetExerA();
            expect(videos, containsAll(videosOf(workout.workout_partsA)), reason: 'level $level');
        }
    });

    test('the videos of workout B are all there, in each leg and core turn', () async {
        // The first level of every band of workout B, and one far past the last.
        for (final int level in <int>[150, 190, 230, 310, 350, 390, 430, 470, 510, 550, 900]) {
            for (int legs = 1; legs <= 3; legs++) {
                for (int core = 1; core <= 2; core++) {
                    user(level, <String, Object>{'switch': legs, 'coreSwitch': core});
                    final Set<String> videos = await nextWorkoutVideos();

                    final WorkoutB workout = WorkoutB();
                    await workout.SetExerB();
                    expect(
                        videos,
                        containsAll(videosOf(workout.workout_partsB)),
                        reason: 'level $level, legs $legs, core $core',
                    );
                }
            }
        }
    });

    test('the warm-up\'s videos are there too, from where it starts', () async {
        user(129);
        final Warmup none = Warmup();
        await none.setWarmup();
        expect(none.warmup_parts, isEmpty);

        // Its first level, the first level of workout B, and where its third
        // exercise changes.
        for (final int level in <int>[130, 150, 270, 300]) {
            user(level);
            final Set<String> videos = await nextWorkoutVideos();

            final Warmup warmup = Warmup();
            await warmup.setWarmup();
            expect(videos, containsAll(videosOf(warmup.warmup_parts)), reason: 'level $level');
        }
    });

    test('a park workout brings the videos of its own pulls', () async {
        // All along the park ladder, and well past its last stage.
        for (int parkLevel = 0; parkLevel <= 480; parkLevel += 40) {
            user(200, <String, Object>{
                'placeSwitch': 1,
                'pullTestDone': true,
                'parkLevel': parkLevel,
            });
            final Set<String> videos = await nextWorkoutVideos();

            for (final String nameKey in WorkoutBPark.pulls(parkLevel, 3)) {
                expect(
                    videos,
                    contains(WorkoutBPark.exercise(nameKey)['videoPath']),
                    reason: 'park level $parkLevel, $nameKey',
                );
            }
        }
    });

    test('whatever the pull test brings up in a workout is among them', () async {
        // The results of the tests of one workout: none entered yet, the first
        // one failed, the first passed and the second failed, and both passed.
        const List<List<int>> outcomes = <List<int>>[
            <int>[],
            <int>[0],
            <int>[99, 0],
            <int>[99, 99],
        ];

        for (int startLvl = 1; startLvl <= 4; startLvl++) {
            for (final List<int> results in outcomes) {
                user(200, <String, Object>{'placeSwitch': 1, 'pullLvl': startLvl});
                final Set<String> videos = await nextWorkoutVideos();

                final WorkoutB workout = WorkoutB();
                await workout.SetExerB();
                final PullTest pullTest = (await PullTest.start(workout.workout_partsB))!;
                final List<int> slots = WorkoutBPark.pullSlots(workout.workout_partsB);
                for (int i = 0; i < results.length; i++) {
                    await pullTest.record(slots[i], results[i]);
                }

                for (final int slot in slots) {
                    expect(
                        videos,
                        contains(pullTest.exerciseAt(slot)!['videoPath']),
                        reason: 'pull level $startLvl, results $results, workout part $slot',
                    );
                }
            }
        }
    });
}
