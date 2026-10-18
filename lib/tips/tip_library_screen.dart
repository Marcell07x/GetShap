import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';

import 'package:getshap/common/ui/app_card.dart';
import 'package:getshap/common/ui/app_scaffold.dart';
import 'package:getshap/l10n/app_localizations.dart';
import 'package:getshap/theme/app_colors.dart';
import 'package:getshap/theme/app_spacing.dart';
import 'package:getshap/theme/app_typography.dart';
import 'package:getshap/tips/tip_detail_screen.dart';
import 'package:getshap/tips/tip_manager.dart';
import 'package:getshap/tips/tips_data.dart';

/// The tips of one type the user has already been given, opened from the side
/// menu.
class TipLibraryScreen extends StatelessWidget {
    /// "Mindset", "Edzés" or "Diéta": the page title, and the type in front of
    /// "TIPP" on the detail screen.
    final String type;

    /// Every tip of this type, in the order the rotation gives them out.
    final List<TipItem> tips;

    const TipLibraryScreen({super.key, required this.type, required this.tips});

    @override
    Widget build(BuildContext context) {
        final AppLocalizations l = AppLocalizations.of(context)!;
        final List<TipItem> shown =
            tips.where((t) => TipManager().tipLibrary.contains(t.id)).toList();

        return AppScaffold(
            title: type,
            swipeToPop: true,
            centerScrollable: shown.isEmpty,
            // The list carries the page padding itself: inside the scaffold's
            // padding it would clip the cards' shadows at its sides.
            padding: shown.isEmpty ? AppSpacing.page : EdgeInsets.zero,
            body: shown.isEmpty
                ? Text(
                    l.noTipsYet,
                    textAlign: TextAlign.center,
                    style: AppText.titleMedium.copyWith(color: AppColors.n600),
                )
                : ListView.separated(
                    padding: AppSpacing.pageAll,
                    itemCount: shown.length,
                    separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, i) {
                        final String tip = shown[i].getText(context);
                        // The home screen's card, slimmed to two lines: the
                        // full tip is one tap away.
                        return AppCard(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                                vertical: AppSpacing.md,
                            ),
                            onTap: () => Navigator.of(context).push(
                                CupertinoPageRoute<void>(
                                    builder: (context) => TipDetailScreen(type: type, tip: tip),
                                ),
                            ),
                            child: Text(
                                tip,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppText.bodyMedium.copyWith(color: AppColors.n900),
                            ),
                        );
                    },
                ),
        );
    }
}
