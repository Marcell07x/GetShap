// Guards for the legal documents the app ships: every app language has all
// three, each translation is built like the English text, none of them shows
// raw markdown, and the consent screen opens them inside the app.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';

import 'package:getshap/core/legal.dart';
import 'package:getshap/l10n/app_localizations.dart';
import 'package:getshap/onboarding/consent_page.dart';
import 'package:getshap/onboarding/legal_document_page.dart';
import 'package:getshap/theme/app_theme.dart';

Widget _host(Widget child, String locale) {
    return MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(locale),
        home: child,
    );
}

/// The three documents' assets in [locale], as the app picks them.
Future<List<String>> _assets(WidgetTester tester, String locale) async {
    late List<String> assets;
    await tester.pumpWidget(
        _host(
            Builder(
                builder: (BuildContext context) {
                    assets = <String>[
                        Legal.termsAsset(context),
                        Legal.healthAsset(context),
                        Legal.privacyAsset(context),
                    ];
                    return const SizedBox.shrink();
                },
            ),
            locale,
        ),
    );
    return assets;
}

/// What a translation must not lose: its sections, list items, table rows,
/// quote, rules and links.
List<int> _shape(String markdown) {
    final List<String> lines = markdown.replaceAll('\r\n', '\n').split('\n');
    int lineCount(String pattern) => lines.where(RegExp(pattern).hasMatch).length;

    return <int>[
        lineCount(r'^## '),
        lineCount(r'^\s*[-*] '),
        lineCount(r'^\d+\. '),
        lineCount(r'^\|'),
        lineCount(r'^>'),
        lineCount(r'^---$'),
        RegExp(r'\]\(\./').allMatches(markdown).length,
        RegExp(r'<https?://').allMatches(markdown).length,
    ];
}

void main() {
    // An asset read in an earlier test stays cached as that test's future, in
    // that test's fake-async zone, and a page waiting on it would never get
    // its text.
    setUp(() => rootBundle.clear());

    final Iterable<String> locales =
        AppLocalizations.supportedLocales.map((Locale locale) => locale.languageCode);

    for (final String locale in locales) {
        testWidgets('[$locale] has all three documents, built like the English ones',
            (WidgetTester tester) async {
            final List<String> english = await _assets(tester, 'en');
            final List<String> assets = await _assets(tester, locale);

            for (int i = 0; i < assets.length; i++) {
                final File file = File(assets[i]);
                expect(file.existsSync(), isTrue, reason: '${assets[i]} is missing');

                final String markdown = file.readAsStringSync();
                expect(
                    _shape(markdown),
                    _shape(File(english[i]).readAsStringSync()),
                    reason: '${assets[i]} does not have the sections, list items, '
                        'table rows and links of ${english[i]}',
                );

                for (final RegExpMatch link in RegExp(r'\]\(\./([^)]+)\)').allMatches(markdown)) {
                    expect(
                        File('${file.parent.path}/${link[1]}').existsSync(),
                        isTrue,
                        reason: '${assets[i]} links to ${link[1]}, which is not there',
                    );
                }
            }
        });

        testWidgets('[$locale] shows no markdown syntax in any document', (WidgetTester tester) async {
            for (final String asset in await _assets(tester, locale)) {
                await tester.pumpWidget(_host(LegalDocumentPage(asset: asset), locale));
                await tester.pumpAndSettle();

                final List<String> texts = tester
                    .widgetList<RichText>(find.byType(RichText))
                    .map((RichText text) => text.text.toPlainText())
                    .toList();

                expect(texts.any((String text) => text.startsWith('GetShap')), isTrue,
                    reason: '$asset did not render its title');
                for (final String text in texts) {
                    expect(text, isNot(matches(RegExp(r'\*\*|\]\(|<https?:|`|\||^#'))),
                        reason: '$asset shows markdown: $text');
                }
            }
        });
    }

    testWidgets('the consent screen opens a document inside the app, and its links to the others',
        (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1080, 2340);
        tester.view.devicePixelRatio = 3.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
            _host(ConsentPage(nextBuilder: (_) => const SizedBox.shrink()), 'en'),
        );
        await tester.ensureVisible(find.text('Terms of Use'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Terms of Use'));
        await tester.pumpAndSettle();

        expect(find.byType(LegalDocumentPage), findsOneWidget);
        expect(find.text('GetShap – Terms of Use'), findsOneWidget);

        const String link = 'Health Disclaimer and Assumption of Risk';
        await tester.ensureVisible(find.textContaining(link));
        await tester.pumpAndSettle();
        await tester.tapOnText(find.textRange.ofSubstring(link));
        await tester.pumpAndSettle();

        expect(find.text('GetShap – Health Disclaimer and Assumption of Risk'), findsOneWidget);
    });
}
