import 'package:flutter/material.dart';

import 'package:getshap/common/ui/app_card.dart';
import 'package:getshap/common/ui/app_scaffold.dart';
import 'package:getshap/l10n/app_localizations.dart';
import 'package:getshap/theme/app_colors.dart';
import 'package:getshap/theme/app_typography.dart';

class TipDetailScreen extends StatelessWidget {
    /// "Mindset", "Workout" or "Diet", shown in front of "TIP" in the header.
    final String type;
    final String tip;
    const TipDetailScreen({super.key, required this.type, required this.tip});

    @override
    Widget build(BuildContext context) {
        final AppLocalizations l = AppLocalizations.of(context)!;

        return AppScaffold(
            title: l.tip,
            swipeToPop: true,
            centerScrollable: true,
            body: AppCard.section(
                eyebrowPrefix: type,
                eyebrow: l.tip,
                // The home screen's tip size, so opening the card does not
                // shrink the text it just showed.
                child: Text(
                    tip,
                    style: AppText.weight(AppText.titleLarge, 400).copyWith(
                        color: AppColors.n600,
                        height: 1.45,
                    ),
                ),
            ),
        );
    }
}
