import 'package:flutter/widgets.dart';

/// [text] in capitals, by the rules of the app's current language.
///
/// Dart's toUpperCase() uses one mapping for every language. Turkish has a
/// dotted and a dotless i, so its "i" has to become "İ" rather than "I"
/// ("ipucu" → "İPUCU"); the dotless "ı" already becomes "I". Every other
/// language keeps the plain mapping.
String upperCase(BuildContext context, String text) {
    if (Localizations.localeOf(context).languageCode == 'tr') {
        text = text.replaceAll('i', 'İ');
    }
    return text.toUpperCase();
}
