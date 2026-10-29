import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getshap/core/workout_signal.dart';
import 'package:getshap/l10n/app_localizations.dart';
import 'package:getshap/onboarding/question_template.dart';

/// Whether the home-or-park question is due: from level 150, until it is
/// answered.
///
/// It is not asked of 60+ users who did not use to play sports regularly. For
/// them it counts as answered here, with home kept, so the menu row still
/// lets them switch.
Future<bool> placeQuestionDue() async {
    final prefs = await SharedPreferences.getInstance();
    if ((prefs.getInt('level') ?? 1) < WorkoutSignal.phaseBLevel ||
        (prefs.getBool('placeQuestionAnswered') ?? false)) {
        return false;
    }

    final bool over60 = (prefs.getInt('age') ?? 0) == 3;
    final bool usedToPlaySports = prefs.getBool('previous_exp_1') ?? false;
    if (over60 && !usedToPlaySports) {
        await prefs.setBool('placeQuestionAnswered', true);
        return false;
    }
    return true;
}

/// Home or park. Comes instead of the home screen once level 150 is reached,
/// and has to be answered. Later the menu switches it in a small window
/// (WorkoutPlaceTile).
class WorkoutPlacePage extends StatelessWidget {
    /// Where to go after the answer when this page is the first screen: the
    /// app was closed before an answer. Without it the page pops.
    final WidgetBuilder? nextBuilder;

    const WorkoutPlacePage({super.key, this.nextBuilder});

    @override
    Widget build(BuildContext context) {
        final l = AppLocalizations.of(context)!;
        return PopScope(
            canPop: false,
            child: QuestionTemplate(
                title: l.workoutPlaceQuestion,
                note: l.workoutPlaceNote,
                showBack: false,
                nextLabel: l.finish,
                options: [
                    QuestionOption(l.atHome, 0),
                    QuestionOption(l.inPark, 1),
                ],
                onNext: (ctx, value) async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setInt('placeSwitch', value as int);
                    await prefs.setBool('placeQuestionAnswered', true);
                    if (!ctx.mounted) return;
                    if (nextBuilder != null) {
                        Navigator.of(ctx).pushReplacement(
                            MaterialPageRoute<void>(builder: nextBuilder!),
                        );
                    } else {
                        Navigator.of(ctx).pop();
                    }
                },
            ),
        );
    }
}
