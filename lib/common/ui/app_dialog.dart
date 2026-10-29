import 'package:flutter/material.dart';

import 'package:getshap/common/ui/app_button.dart';
import 'package:getshap/theme/app_colors.dart';
import 'package:getshap/theme/app_spacing.dart';
import 'package:getshap/theme/app_typography.dart';

/// The app's small pop-up window, for a quick question inside a flow.
///
/// Laid out like a Material 3 dialog with a hero icon: the icon in a soft
/// brand circle, a centred title, then whatever the question needs. The
/// buttons are the app's own, full width and stacked, the main action on top
/// and the way out under it. Stacked rather than side by side, because pairs
/// like "Abbrechen" / "Speichern" do not fit next to each other at a large
/// system font.
class AppDialog extends StatelessWidget {
    final IconData icon;
    final String title;

    /// Under the title, e.g. the choices to pick from.
    final Widget? content;

    final String primaryLabel;
    final VoidCallback onPrimary;
    final String secondaryLabel;
    final VoidCallback onSecondary;

    const AppDialog({
        super.key,
        required this.icon,
        required this.title,
        this.content,
        required this.primaryLabel,
        required this.onPrimary,
        required this.secondaryLabel,
        required this.onSecondary,
    });

    @override
    Widget build(BuildContext context) {
        return Dialog(
            backgroundColor: AppColors.surface,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.all(AppRadius.xl)),
            // The page's own side margin rather than Flutter's 40: at a large
            // system font every word of the title needs the room.
            insetPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.xxl,
            ),
            // Taller than the screen only at the largest system fonts.
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                        Center(
                            child: Container(
                                width: 56,
                                height: 56,
                                decoration: const BoxDecoration(
                                    color: AppColors.brand50,
                                    shape: BoxShape.circle,
                                ),
                                child: Icon(icon, color: AppColors.brand500, size: 28),
                            ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                            title,
                            textAlign: TextAlign.center,
                            style: AppText.titleLarge.copyWith(color: AppColors.n900),
                        ),
                        if (content != null) ...<Widget>[
                            const SizedBox(height: AppSpacing.xl),
                            content!,
                        ],
                        const SizedBox(height: AppSpacing.xxl),
                        AppButton(
                            label: primaryLabel,
                            size: AppButtonSize.md,
                            onPressed: onPrimary,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppButton(
                            label: secondaryLabel,
                            variant: AppButtonVariant.ghost,
                            size: AppButtonSize.md,
                            onPressed: onSecondary,
                        ),
                    ],
                ),
            ),
        );
    }
}
