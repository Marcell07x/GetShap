// Generates the public legal pages from the markdown documents in this folder.
//
//   dart run legal/build_site.dart
//
// Output goes to legal/site/, laid out as directories with index.html files so
// the clean URLs (/terms, /hu/feltetelek, /de/terms, ...) work on any static
// host without rewrite rules. Copy the *contents* of legal/site/ into the
// website folder. Only the document pages are generated: the landing pages
// (/, /hu/, /de/, ...) are hand-made and live in the website folder alone, so
// copying never touches them.
//
// The markdown here is hand-written and uses a small, known subset, so this
// converter only implements that subset rather than pulling in a dependency:
// headings, paragraphs, bold, inline code, links, autolinks, bullet and
// numbered lists, tables and horizontal rules. The app shows the same files
// and renders the same subset (lib/onboarding/legal_document_page.dart).

import 'dart:io';

/// One published document: where its markdown lives, where it goes on the web,
/// and the title shown in the footer navigation.
class Doc {
    final String source;
    final String outPath;
    final String navLabel;

    const Doc({
        required this.source,
        required this.outPath,
        required this.navLabel,
    });
}

/// One language's copy of the three documents.
class Lang {
    final String code;

    /// The language's own name, as the language menu lists it.
    final String name;

    /// Terms, health disclaimer, privacy policy – in this order in every
    /// language, so the language menu can link each one to its translations.
    final List<Doc> docs;

    const Lang({required this.code, required this.name, required this.docs});

    /// The language's landing page.
    String get home => code == 'en' ? '/' : '/$code/';
}

/// English and Hungarian came first and keep their addresses, which older app
/// versions and the stores link to. Every other language lives under its own
/// code, with the English file names and paths.
final List<Lang> langs = [
    const Lang(code: 'en', name: 'English', docs: [
        Doc(
            source: 'legal/en/terms-of-use.md',
            outPath: 'terms',
            navLabel: 'Terms of Use',
        ),
        Doc(
            source: 'legal/en/health-disclaimer.md',
            outPath: 'health',
            navLabel: 'Health Disclaimer',
        ),
        Doc(
            source: 'legal/en/privacy-policy.md',
            outPath: 'privacy',
            navLabel: 'Privacy Policy',
        ),
    ]),
    const Lang(code: 'hu', name: 'Magyar', docs: [
        Doc(
            source: 'legal/hu/felhasznalasi-feltetelek.md',
            outPath: 'hu/feltetelek',
            navLabel: 'Felhasználási feltételek',
        ),
        Doc(
            source: 'legal/hu/egeszsegugyi-tajekoztato.md',
            outPath: 'hu/egeszseg',
            navLabel: 'Egészségügyi tájékoztató',
        ),
        Doc(
            source: 'legal/hu/adatvedelmi-tajekoztato.md',
            outPath: 'hu/adatvedelem',
            navLabel: 'Adatvédelem',
        ),
    ]),
    _translated('de', 'Deutsch',
        'Nutzungsbedingungen', 'Gesundheitshinweis', 'Datenschutzerklärung'),
    _translated('es', 'Español',
        'Términos de uso', 'Aviso de salud', 'Política de privacidad'),
    _translated('fr', 'Français',
        "Conditions d'utilisation", 'Avertissement santé', 'Politique de confidentialité'),
    _translated('it', 'Italiano',
        'Termini di utilizzo', 'Avvertenza sulla salute', 'Informativa sulla privacy'),
    _translated('pt', 'Português',
        'Termos de Uso', 'Aviso de Saúde', 'Política de Privacidade'),
    _translated('ru', 'Русский',
        'Условия использования', 'Предупреждение о здоровье', 'Политика конфиденциальности'),
    _translated('tr', 'Türkçe',
        'Kullanım Koşulları', 'Sağlık Uyarısı', 'Gizlilik Politikası'),
];

Lang _translated(
    String code,
    String name,
    String terms,
    String health,
    String privacy,
) {
    return Lang(code: code, name: name, docs: [
        Doc(source: 'legal/$code/terms-of-use.md', outPath: '$code/terms', navLabel: terms),
        Doc(source: 'legal/$code/health-disclaimer.md', outPath: '$code/health', navLabel: health),
        Doc(source: 'legal/$code/privacy-policy.md', outPath: '$code/privacy', navLabel: privacy),
    ]);
}

void main() {
    final outputRoot = Directory('legal/site');
    if (outputRoot.existsSync()) outputRoot.deleteSync(recursive: true);

    for (final lang in langs) {
        for (var index = 0; index < lang.docs.length; index++) {
            final doc = lang.docs[index];
            final file = File(doc.source);
            if (!file.existsSync()) {
                stderr.writeln('Missing source: ${doc.source}');
                exitCode = 1;
                return;
            }

            final markdown = file.readAsStringSync();
            final html = _page(
                lang: lang,
                index: index,
                title: _firstHeading(markdown),
                body: _renderBlocks(markdown, lang),
            );

            final target = File('legal/site/${doc.outPath}/index.html');
            target.parent.createSync(recursive: true);
            target.writeAsStringSync(html);
            stdout.writeln('${doc.outPath}/index.html  <-  ${doc.source}');
        }
    }

    stdout.writeln('\nDone. Copy the contents of legal/site/ into the website folder.');
}

String _firstHeading(String markdown) {
    for (final line in markdown.split('\n')) {
        if (line.startsWith('# ')) return line.substring(2).trim();
    }
    return 'GetShap';
}

/// The documents link to each other by relative markdown path; on the web that
/// becomes the other document's address in the same language.
String _href(String target, Lang lang) {
    if (!target.startsWith('./')) return target;
    final file = target.substring(2);
    for (final doc in lang.docs) {
        if (doc.source.endsWith('/$file')) return '/${doc.outPath}/';
    }
    return target;
}

// ---------------------------------------------------------------------------
// Block-level conversion
// ---------------------------------------------------------------------------

String _renderBlocks(String markdown, Lang lang) {
    final lines = markdown.replaceAll('\r\n', '\n').split('\n');
    final out = StringBuffer();
    var i = 0;

    while (i < lines.length) {
        final line = lines[i];
        final trimmed = line.trim();

        if (trimmed.isEmpty) {
            i++;
            continue;
        }

        if (trimmed == '---') {
            out.writeln('<hr>');
            i++;
            continue;
        }

        if (trimmed.startsWith('#')) {
            final level = trimmed.split(' ').first.length;
            final text = trimmed.substring(level).trim();
            // The document's own H1 is rendered by the page template, so it is
            // skipped here to avoid printing the title twice.
            if (level > 1) {
                out.writeln('<h$level>${_inline(text, lang)}</h$level>');
            }
            i++;
            continue;
        }

        if (trimmed.startsWith('>')) {
            final quoted = <String>[];
            while (i < lines.length && lines[i].trim().startsWith('>')) {
                quoted.add(lines[i].trim().substring(1).trim());
                i++;
            }
            out.writeln('<blockquote>${_inline(quoted.join(' '), lang)}</blockquote>');
            continue;
        }

        if (trimmed.startsWith('|')) {
            final table = <String>[];
            while (i < lines.length && lines[i].trim().startsWith('|')) {
                table.add(lines[i].trim());
                i++;
            }
            out.writeln(_renderTable(table, lang));
            continue;
        }

        if (_isBullet(trimmed) || _isNumbered(trimmed)) {
            final ordered = _isNumbered(trimmed);
            final items = <String>[];
            while (i < lines.length) {
                final current = lines[i];
                final currentTrimmed = current.trim();
                if (currentTrimmed.isEmpty) break;
                if (_isBullet(currentTrimmed) || _isNumbered(currentTrimmed)) {
                    items.add(_stripMarker(currentTrimmed));
                } else if (items.isNotEmpty) {
                    // Wrapped continuation of the previous item.
                    items[items.length - 1] += ' $currentTrimmed';
                } else {
                    break;
                }
                i++;
            }
            final tag = ordered ? 'ol' : 'ul';
            out.writeln('<$tag>');
            for (final item in items) {
                out.writeln('<li>${_inline(item, lang)}</li>');
            }
            out.writeln('</$tag>');
            continue;
        }

        // Plain paragraph: join the hard-wrapped lines back together.
        final paragraph = <String>[];
        while (i < lines.length) {
            final current = lines[i].trim();
            if (current.isEmpty ||
                current == '---' ||
                current.startsWith('#') ||
                current.startsWith('|') ||
                current.startsWith('>') ||
                _isBullet(current) ||
                _isNumbered(current)) {
                break;
            }
            paragraph.add(current);
            i++;
        }
        out.writeln('<p>${_inline(paragraph.join(' '), lang)}</p>');
    }

    return out.toString();
}

bool _isBullet(String line) => line.startsWith('- ') || line.startsWith('* ');

bool _isNumbered(String line) => RegExp(r'^\d+\.\s').hasMatch(line);

String _stripMarker(String line) {
    if (_isBullet(line)) return line.substring(2).trim();
    return line.replaceFirst(RegExp(r'^\d+\.\s+'), '').trim();
}

String _renderTable(List<String> rows, Lang lang) {
    List<String> cells(String row) {
        var trimmed = row;
        if (trimmed.startsWith('|')) trimmed = trimmed.substring(1);
        if (trimmed.endsWith('|')) {
            trimmed = trimmed.substring(0, trimmed.length - 1);
        }
        return trimmed.split('|').map((c) => c.trim()).toList();
    }

    bool isSeparator(String row) =>
        RegExp(r'^\|[\s:\-|]+\|?$').hasMatch(row) && row.contains('-');

    final out = StringBuffer('<div class="table-wrap"><table>');
    var wroteHeader = false;

    for (var index = 0; index < rows.length; index++) {
        final row = rows[index];
        if (isSeparator(row)) continue;

        final isHeader = index == 0 &&
            rows.length > 1 &&
            isSeparator(rows[1]);
        final tag = isHeader ? 'th' : 'td';

        if (isHeader) {
            out.write('<thead>');
            wroteHeader = true;
        } else if (wroteHeader) {
            out.write('<tbody>');
            wroteHeader = false;
        }

        out.write('<tr>');
        for (final cell in cells(row)) {
            out.write('<$tag>${_inline(cell, lang)}</$tag>');
        }
        out.write('</tr>');

        if (isHeader) out.write('</thead>');
    }

    out.write('</tbody></table></div>');
    return out.toString();
}

// ---------------------------------------------------------------------------
// Inline conversion
// ---------------------------------------------------------------------------

String _inline(String text, Lang lang) {
    // Escape first, so anything in the source is inert; the patterns below then
    // match against the escaped form (autolinks become &lt;...&gt;).
    var result = text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;');

    result = result.replaceAllMapped(
        RegExp(r'`([^`]+)`'),
        (m) => '<code>${m[1]}</code>',
    );

    result = result.replaceAllMapped(
        RegExp(r'\[([^\]]+)\]\(([^)]+)\)'),
        (m) => '<a href="${_href(m[2]!, lang)}">${m[1]}</a>',
    );

    result = result.replaceAllMapped(
        RegExp(r'&lt;(https?://[^&\s]+)&gt;'),
        (m) => '<a href="${m[1]}">${m[1]}</a>',
    );

    result = result.replaceAllMapped(
        RegExp(r'\*\*([^*]+)\*\*'),
        (m) => '<strong>${m[1]}</strong>',
    );

    return result;
}

// ---------------------------------------------------------------------------
// Page template
// ---------------------------------------------------------------------------

/// The page for document [index] of [lang]: its language menu links the same
/// document in every language, its footer the language's other two documents.
String _page({
    required Lang lang,
    required int index,
    required String title,
    required String body,
}) {
    final doc = lang.docs[index];

    final alternates = [
        for (final other in langs)
            '<link rel="alternate" hreflang="${other.code}" '
                'href="https://getshap.com/${other.docs[index].outPath}/">',
        '<link rel="alternate" hreflang="x-default" '
            'href="https://getshap.com/${langs.first.docs[index].outPath}/">',
    ].join('\n');

    final menu = [
        for (final other in langs)
            '<a href="/${other.docs[index].outPath}/" hreflang="${other.code}" '
                'lang="${other.code}"${other == lang ? ' aria-current="page"' : ''}>'
                '${other.name}</a>',
    ].join('\n                ');

    final navLinks = lang.docs
        .where((d) => d != doc)
        .map((d) => '<a href="/${d.outPath}/">${d.navLabel}</a>')
        .join('\n            ');

    return '''<!doctype html>
<html lang="${lang.code}">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$title</title>
<link rel="canonical" href="https://getshap.com/${doc.outPath}/">
$alternates
<style>
:root {
    --blue: #2E6BF0;
    --text: #1c1e21;
    --muted: #5b6470;
    --line: #e2e5ea;
    --bg: #ffffff;
    --card: #f7f8fa;
}
@media (prefers-color-scheme: dark) {
    :root {
        --text: #e8eaed;
        --muted: #a3abb6;
        --line: #333a44;
        --bg: #16181c;
        --card: #1e2127;
    }
}
* { box-sizing: border-box; }
body {
    margin: 0;
    background: var(--bg);
    color: var(--text);
    font: 16px/1.65 -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
    -webkit-text-size-adjust: 100%;
}
.wrap { max-width: 760px; margin: 0 auto; padding: 0 20px 64px; }
header {
    background: var(--blue);
    padding: 22px 20px;
    margin-bottom: 36px;
}
header .inner {
    max-width: 760px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
}
header a { color: #fff; text-decoration: none; }
header .brand { font-size: 21px; font-weight: 800; letter-spacing: .3px; }
.lang { position: relative; }
.lang summary {
    list-style: none;
    cursor: pointer;
    user-select: none;
    color: #fff;
    font-size: 14px;
    border: 1px solid rgba(255,255,255,.55);
    border-radius: 999px;
    padding: 4px 12px;
    white-space: nowrap;
}
.lang summary::-webkit-details-marker { display: none; }
.lang summary::after { content: " \\25BE"; }
.lang nav {
    position: absolute;
    right: 0;
    top: calc(100% + 8px);
    z-index: 10;
    min-width: 170px;
    padding: 6px;
    background: var(--bg);
    border: 1px solid var(--line);
    border-radius: 12px;
    box-shadow: 0 12px 32px rgba(0,0,0,.18);
}
.lang nav a {
    display: block;
    padding: 8px 12px;
    border-radius: 8px;
    color: var(--text);
    font-size: 15px;
}
.lang nav a:hover { background: var(--card); }
.lang nav a[aria-current] { color: var(--blue); font-weight: 600; }
h1 { font-size: 30px; line-height: 1.25; margin: 0 0 8px; }
h2 { font-size: 20px; margin: 38px 0 10px; }
h3 { font-size: 17px; margin: 28px 0 8px; }
p, li { color: var(--text); }
a { color: var(--blue); }
ul, ol { padding-left: 22px; }
li { margin: 6px 0; }
hr { border: 0; border-top: 1px solid var(--line); margin: 34px 0; }
blockquote {
    margin: 22px 0;
    padding: 16px 18px;
    background: var(--card);
    border-left: 4px solid var(--blue);
    border-radius: 6px;
}
code {
    background: var(--card);
    padding: 1px 5px;
    border-radius: 4px;
    font-size: 14px;
}
.table-wrap { overflow-x: auto; margin: 16px 0; }
table { border-collapse: collapse; width: 100%; font-size: 15px; }
th, td {
    border: 1px solid var(--line);
    padding: 9px 12px;
    text-align: left;
    vertical-align: top;
}
th { background: var(--card); font-weight: 600; }
footer {
    margin-top: 52px;
    padding-top: 22px;
    border-top: 1px solid var(--line);
    font-size: 15px;
    color: var(--muted);
}
footer a { display: inline-block; margin-right: 18px; }
</style>
</head>
<body>
<header>
    <div class="inner">
        <a class="brand" href="${lang.home}">GetShap</a>
        <details class="lang">
            <summary>${lang.name}</summary>
            <nav>
                $menu
            </nav>
        </details>
    </div>
</header>
<div class="wrap">
    <h1>$title</h1>
$body
    <footer>
            $navLinks
    </footer>
</div>
</body>
</html>
''';
}
