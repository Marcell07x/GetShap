import 'package:flutter/widgets.dart';

/// The app's language: the phone's own language when the app has it,
/// English otherwise.
///
/// Only the first language in the phone's list counts. Flutter's default
/// would go on down the list, so a Japanese phone with German as a second
/// language would get German; here it gets English. A language picked for
/// GetShap alone in the system settings (iOS, Android 13+) arrives as that
/// first language. The region is ignored: pt-PT gets the Portuguese text and
/// es-MX the Spanish one.
Locale appLocale(List<Locale>? phoneLocales, Iterable<Locale> supportedLocales) {
    final String? language = phoneLocales == null || phoneLocales.isEmpty
        ? null
        : phoneLocales.first.languageCode;
    for (final Locale locale in supportedLocales) {
        if (locale.languageCode == language) return locale;
    }
    return const Locale('en');
}
