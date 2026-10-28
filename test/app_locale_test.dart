// The app's language: the phone's own language when the app has it, English
// otherwise. Only the first language in the phone's list counts.
//
// Flutter's default would pick the first entry of supportedLocales for an
// unsupported phone, and gen-l10n sorts that list alphabetically, so German
// would win. On a Hungarian phone nobody would notice that breaking.

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:getshap/core/app_locale.dart';
import 'package:getshap/l10n/app_localizations.dart';

void main() {
    Locale resolve(List<Locale>? phoneLocales) =>
        appLocale(phoneLocales, AppLocalizations.supportedLocales);

    test('a supported phone language is used', () {
        expect(resolve(const <Locale>[Locale('hu', 'HU'), Locale('en', 'US')]), const Locale('hu'));
        expect(resolve(const <Locale>[Locale('tr', 'TR')]), const Locale('tr'));
    });

    test('the region does not matter', () {
        expect(resolve(const <Locale>[Locale('fr', 'CA')]), const Locale('fr'));
        expect(resolve(const <Locale>[Locale('pt', 'PT')]), const Locale('pt'));
        expect(resolve(const <Locale>[Locale('es', 'MX')]), const Locale('es'));
    });

    test('an unsupported phone language gets English', () {
        expect(resolve(const <Locale>[Locale('ja', 'JP')]), const Locale('en'));
    });

    test('the languages after the first one do not count', () {
        expect(resolve(const <Locale>[Locale('ja', 'JP'), Locale('de', 'DE')]), const Locale('en'));
    });

    test('a phone that reports no language gets English', () {
        expect(resolve(const <Locale>[]), const Locale('en'));
        expect(resolve(null), const Locale('en'));
    });
}
