import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:getshap/common/ui/app_button.dart';
import 'package:getshap/common/upper_case.dart';
import 'package:getshap/core/streak/streak_increase.dart';
import 'package:getshap/l10n/app_localizations.dart';
import 'package:getshap/theme/app_colors.dart';
import 'package:getshap/theme/app_spacing.dart';
import 'package:getshap/theme/app_theme.dart';
import 'package:getshap/theme/app_typography.dart';
import 'package:getshap/workout/workout_place_page.dart';

/// The reward screen after a finished workout.
///
/// The one page in the app that goes full-bleed brand blue: it is the moment
/// worth marking, and the saturated field makes the streak flame and the
/// counting number the brightest things on screen.
class CongratulationsScreen extends StatelessWidget {
    const CongratulationsScreen({super.key});

    /// Back to the home screen, or, once level 150 is reached, to the
    /// home-or-park question in its place.
    Future<void> _finish(BuildContext context) async {
        final navigator = Navigator.of(context);
        if (await placeQuestionDue()) {
            navigator.pushReplacement(
                MaterialPageRoute<void>(builder: (context) => const WorkoutPlacePage()),
            );
        } else {
            navigator.popUntil((route) => route.isFirst);
        }
    }

    @override
    Widget build(BuildContext context) {
        final l10n = AppLocalizations.of(context)!;

        return AnnotatedRegion<SystemUiOverlayStyle>(
            // No app bar here, so the theme's overlay style never applies. The
            // navigation bar takes brand800 — where this screen's gradient ends,
            // right above it — so the bottom of the page runs into the bottom of
            // the screen without a seam.
            value: AppTheme.systemBarsOn(AppColors.brand800),
            child: Scaffold(
                backgroundColor: AppColors.brand800,
                body: DecoratedBox(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[AppColors.brand500, AppColors.brand800],
                        ),
                    ),
                    child: SafeArea(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                AppSpacing.xl,
                                AppSpacing.lg,
                                AppSpacing.xl,
                                AppSpacing.xxl,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                    // Centred above the button, but scrollable:
                                    // at the largest system font the title,
                                    // the counter and the message are taller
                                    // than the space the button leaves.
                                    Expanded(
                                        child: LayoutBuilder(
                                            builder: (context, constraints) => SingleChildScrollView(
                                                child: ConstrainedBox(
                                                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                                                    child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                            Text(
                                                                l10n.congrat,
                                                                textAlign: TextAlign.center,
                                                                style: AppText.headlineLarge.copyWith(
                                                                    color: AppColors.onBrand,
                                                                ),
                                                            ),
                                                            const SizedBox(height: AppSpacing.xl),
                                                            const StreakIncrease(),
                                                            const SizedBox(height: AppSpacing.md),
                                                            Text(
                                                                upperCase(context, l10n.workoutStreak),
                                                                textAlign: TextAlign.center,
                                                                style: AppText.eyebrow.copyWith(
                                                                    color: AppColors.brand200,
                                                                ),
                                                            ),
                                                            const SizedBox(height: AppSpacing.xxxl),
                                                            Text(
                                                                l10n.congratMessage,
                                                                textAlign: TextAlign.center,
                                                                style: AppText.titleMedium.copyWith(
                                                                    color: AppColors.onBrand,
                                                                ),
                                                            ),
                                                        ],
                                                    ),
                                                ),
                                            ),
                                        ),
                                    ),
                                    AppButton(
                                        label: upperCase(context, l10n.finish),
                                        variant: AppButtonVariant.inverse,
                                        onPressed: () => _finish(context),
                                    ),
                                ],
                            ),
                        ),
                    ),
                ),
            ),
        );
    }
}
