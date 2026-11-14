import 'package:flutter/foundation.dart' show debugPrint;

import 'package:getshap/core/level.dart';
import 'package:getshap/core/workout_signal.dart';
import 'package:getshap/warmup/warmup.dart';
import 'package:getshap/workout/exercise_videos.dart';
import 'package:getshap/workout/pull_test.dart';
import 'package:getshap/workout/workouta.dart';
import 'package:getshap/workout/workoutb.dart';

/// The videos of the next workout, its warm-up included: what the user will
/// see when they next press Start, as things stand now.
///
/// It asks the same builders the workout itself is put together with, so
/// whatever they come to show is what is downloaded.
Future<Set<String>> nextWorkoutVideos() async {
    final WorkoutLevel workoutLevel = WorkoutLevel();
    await workoutLevel.getLevel();

    final List<Map<String, String>> exercises = <Map<String, String>>[];

    // Empty below the level where the warm-up starts.
    final Warmup warmup = Warmup();
    await warmup.setWarmup();
    exercises.addAll(warmup.warmup_parts);

    if (workoutLevel.level < WorkoutSignal.phaseBLevel) {
        final WorkoutA workout = WorkoutA();
        await workout.SetExerA();
        exercises.addAll(workout.workout_partsA);
    } else {
        final WorkoutB workout = WorkoutB();
        await workout.SetExerB();
        exercises.addAll(workout.workout_partsB);
        // While the pull test is on, it puts its own exercises on the pull
        // slots.
        final PullTest? pullTest = await PullTest.start(workout.workout_partsB);
        if (pullTest != null) {
            exercises.addAll(pullTest.exercises);
        }
    }

    final Set<String> videos = <String>{};
    for (final Map<String, String> exercise in exercises) {
        videos.add(exercise['videoPath']!);
    }
    return videos;
}

/// Downloads them ahead of time, so the workout can be done without a
/// network. Called wherever the next workout can change: when the home screen
/// comes up, at the end of a workout, and when the place of the workouts is
/// chosen. Nothing waits for it, and a video it could not get is asked for
/// again by the workout screen.
Future<void> downloadNextWorkoutVideos() async {
    try {
        for (final String video in await nextWorkoutVideos()) {
            await ExerciseVideos.get(video);
        }
    } catch (e) {
        debugPrint('Next workout videos not downloaded: $e');
    }
}
