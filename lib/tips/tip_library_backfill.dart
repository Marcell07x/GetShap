import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:getshap/tips/tips_data.dart';

/// Only for users updating from a version that had no tip library: the tips
/// the rotation had already shown them, worked out from the state it stores.
List<String> tipsShownBeforeTipLibrary(SharedPreferences prefs) {
    bool hasFinishedA = prefs.getBool('hasFinishedSectionA') ?? false;
    bool hasCompletedFullCycle = prefs.getBool('hasCompletedFullCycle') ?? false;

    // seenTipsA holds this round of section A from its start up to the
    // current tip: at principles3 it is principles1-3, at beginnerDiet1
    // every principle plus beginnerWorkout1.
    Set<String> shown = {...?prefs.getStringList('seenTipsA')};

    // A full round means every section A tip was shown. The switch to
    // section B deletes hasCompletedFullCycle, so section B counts too.
    // shown is a Set, so a tip already taken from seenTipsA is kept once.
    if (hasFinishedA || hasCompletedFullCycle) {
        for (var tip in [...TipsData.principles, ...TipsData.beginnerWorkout, ...TipsData.beginnerDiet]) {
            shown.add(tip.id);
        }
    }

    // The indices count the tips given from each list. Section B
    // alternates workout and diet, starting with workout, so each count
    // also bounds the other: four diet tips mean at least four workout
    // tips, even after the shorter workout list has wrapped back to 1.
    // Once the diet list has wrapped too, this can come up short.
    if (hasFinishedA) {
        int workout = prefs.getInt('advancedWorkoutIndex') ?? 0;
        int diet = prefs.getInt('advancedDietIndex') ?? 0;
        shown.addAll(TipsData.advancedWorkout.take(max(workout, diet)).map((t) => t.id));
        shown.addAll(TipsData.advancedDiet.take(max(diet, workout - 1)).map((t) => t.id));
    }

    String? lastTipId = prefs.getString('lastTipId');
    if (lastTipId != null) shown.add(lastTipId);

    return shown.toList();
}
