import 'package:flutter/material.dart';

import 'package:getshap/l10n/app_localizations.dart';
import 'package:getshap/tips/tip_manager.dart';
import 'package:getshap/tips/tips_data.dart';

/// The current tip's type — "Mindset", "Edzés" or "Diéta" — shown in bold in
/// the tip card's header ("MINDSET TIPP").
String getTipType(BuildContext context) {
    final AppLocalizations loc = AppLocalizations.of(context)!;
    final tipId = TipManager().currentTipId;
    if (TipsData.principles.any((t) => t.id == tipId)) {
        return loc.tipTypePrinciples;
    } else if (TipsData.beginnerDiet.any((t) => t.id == tipId) ||
            TipsData.advancedDiet.any((t) => t.id == tipId)) {
        return loc.tipTypeDiet;
    } else {
        return loc.tipTypeWorkout;
    }
}
