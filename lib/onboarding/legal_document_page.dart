import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:getshap/common/ui/app_card.dart';
import 'package:getshap/common/ui/app_scaffold.dart';
import 'package:getshap/core/legal.dart';
import 'package:getshap/l10n/app_localizations.dart';
import 'package:getshap/theme/app_colors.dart';
import 'package:getshap/theme/app_spacing.dart';
import 'package:getshap/theme/app_typography.dart';

/// One of the legal documents, read inside the app.
///
/// The text is the markdown the website is built from (`legal/build_site.dart`),
/// bundled as an asset: the consent screen shows what is being accepted without
/// a network and without sending the user out to a browser.
///
/// The documents use a small, known subset of markdown, and this renders the
/// same subset `build_site.dart` turns into HTML: headings, paragraphs, bold,
/// inline code, links, autolinks, bullet and numbered lists, tables, quotes and
/// horizontal rules. Syntax new to the documents has to be added to both.
class LegalDocumentPage extends StatefulWidget {
    /// The markdown file, e.g. `legal/de/terms-of-use.md`: one of
    /// [Legal.termsAsset], [Legal.healthAsset] and [Legal.privacyAsset], or the
    /// document a link in one of them points to.
    final String asset;

    const LegalDocumentPage({super.key, required this.asset});

    @override
    State<LegalDocumentPage> createState() => _LegalDocumentPageState();
}

class _LegalDocumentPageState extends State<LegalDocumentPage> {
    static final TextStyle _body = AppText.bodyMedium.copyWith(color: AppColors.n900);

    /// Bold, inline code, links and autolinks — the inline syntax the
    /// documents use.
    static final RegExp _inline = RegExp(
        r'\*\*(.+?)\*\*' // 1: bold
        r'|`([^`]+)`' // 2: inline code
        r'|\[([^\]]+)\]\(([^)]+)\)' // 3: link text, 4: target
        r'|<(https?://[^>\s]+)>', // 5: autolink
    );

    /// The document, built once the file has been read.
    List<Widget>? _blocks;

    /// The links' tap handlers. A [TextSpan] does not dispose its recognizer,
    /// so the page keeps them and disposes them with itself.
    final List<TapGestureRecognizer> _links = <TapGestureRecognizer>[];

    @override
    void initState() {
        super.initState();
        rootBundle.loadString(widget.asset).then((String markdown) {
            if (mounted) setState(() => _blocks = _buildBlocks(markdown));
        });
    }

    @override
    void dispose() {
        for (final TapGestureRecognizer link in _links) {
            link.dispose();
        }
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return AppScaffold(
            title: AppLocalizations.of(context)!.legal,
            swipeToPop: true,
            // The scroll view carries the page padding itself, so the page
            // scrolls from the very edge of the screen.
            padding: EdgeInsets.zero,
            body: SingleChildScrollView(
                padding: AppSpacing.pageAll,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _blocks ?? const <Widget>[],
                ),
            ),
        );
    }

    /// Splits the document into blocks by the same rules as `build_site.dart`.
    List<Widget> _buildBlocks(String markdown) {
        final List<String> lines = markdown.replaceAll('\r\n', '\n').split('\n');
        final List<Widget> blocks = <Widget>[];
        int i = 0;

        while (i < lines.length) {
            final String line = lines[i].trim();

            if (line.isEmpty) {
                i++;
            } else if (line == '---') {
                blocks.add(const Divider(height: AppSpacing.xxxl));
                i++;
            } else if (line.startsWith('#')) {
                final int level = line.split(' ').first.length;
                blocks.add(_heading(line.substring(level).trim(), isTitle: level == 1));
                i++;
            } else if (line.startsWith('>')) {
                final List<String> quoted = <String>[];
                while (i < lines.length && lines[i].trim().startsWith('>')) {
                    quoted.add(lines[i].trim().substring(1).trim());
                    i++;
                }
                blocks.add(_quote(quoted.join(' ')));
            } else if (line.startsWith('|')) {
                final List<String> rows = <String>[];
                while (i < lines.length && lines[i].trim().startsWith('|')) {
                    rows.add(lines[i].trim());
                    i++;
                }
                blocks.add(_table(rows));
            } else if (_isItem(line)) {
                final bool numbered = _isNumbered(line);
                final List<String> items = <String>[];
                while (i < lines.length && lines[i].trim().isNotEmpty) {
                    final String current = lines[i].trim();
                    if (_isItem(current)) {
                        items.add(current.replaceFirst(RegExp(r'^([-*]|\d+\.)\s+'), ''));
                    } else {
                        // A wrapped line of the item above.
                        items[items.length - 1] += ' $current';
                    }
                    i++;
                }
                for (int n = 0; n < items.length; n++) {
                    blocks.add(_item(numbered ? '${n + 1}.' : null, items[n]));
                }
            } else {
                // A paragraph: its hard-wrapped lines joined back together.
                final List<String> paragraph = <String>[];
                while (i < lines.length) {
                    final String current = lines[i].trim();
                    if (current.isEmpty ||
                        current == '---' ||
                        current.startsWith('#') ||
                        current.startsWith('|') ||
                        current.startsWith('>') ||
                        _isItem(current)) {
                        break;
                    }
                    paragraph.add(current);
                    i++;
                }
                blocks.add(_paragraph(paragraph.join(' ')));
            }
        }

        return blocks;
    }

    static bool _isNumbered(String line) => RegExp(r'^\d+\.\s').hasMatch(line);

    static bool _isItem(String line) =>
        line.startsWith('- ') || line.startsWith('* ') || _isNumbered(line);

    /// The document's own title, or one of its section headings. The title is
    /// one step below the headline sizes: at a 1.3x system font a headline
    /// splits single words like "Datenschutzerklärung" mid-word.
    Widget _heading(String text, {required bool isTitle}) {
        final TextStyle style = isTitle ? AppText.titleLarge : AppText.titleMedium;

        return Padding(
            padding: EdgeInsets.only(
                top: isTitle ? 0 : AppSpacing.xl,
                bottom: isTitle ? AppSpacing.md : AppSpacing.sm,
            ),
            child: Text.rich(
                TextSpan(children: _spans(text, style.copyWith(color: AppColors.n900))),
            ),
        );
    }

    Widget _paragraph(String text) {
        return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Text.rich(TextSpan(children: _spans(text, _body))),
        );
    }

    /// A list item, laid out like the points on the consent screen: the brand
    /// dot, or the item's number, hanging beside the text.
    Widget _item(String? number, String text) {
        return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    if (number == null)
                        const Padding(
                            padding: EdgeInsets.only(top: 5, right: AppSpacing.md),
                            child: Icon(Icons.circle, size: 7, color: AppColors.brand500),
                        )
                    else
                        Padding(
                            padding: const EdgeInsets.only(right: AppSpacing.sm),
                            child: Text(
                                number,
                                style: AppText.numeral(AppText.weight(_body, 700))
                                    .copyWith(color: AppColors.brand500),
                            ),
                        ),
                    Expanded(child: Text.rich(TextSpan(children: _spans(text, _body)))),
                ],
            ),
        );
    }

    /// The warning at the top of the health disclaimer: the consent screen's
    /// "the documents changed" notice.
    Widget _quote(String text) {
        return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: AppCard.notice(
                accent: AppColors.brand500,
                color: AppColors.brand50,
                icon: Icons.info_outline_rounded,
                child: Text.rich(TextSpan(children: _spans(text, _body))),
            ),
        );
    }

    /// The provider's details in the terms. Its header row is empty, and an
    /// empty row is left out rather than drawn as a blank band.
    ///
    /// Set a size below the body text, as on the website, with slim cell
    /// padding: the e-mail address is one unbreakable word, and this keeps it
    /// on one line up to a 1.3x system font in every language.
    Widget _table(List<String> rows) {
        final TextStyle text = AppText.bodySmall.copyWith(color: AppColors.n900);

        bool isSeparator(String row) =>
            RegExp(r'^\|[\s:\-|]+\|?$').hasMatch(row) && row.contains('-');

        List<String> cells(String row) {
            String inner = row.substring(1);
            if (inner.endsWith('|')) inner = inner.substring(0, inner.length - 1);
            return inner.split('|').map((String cell) => cell.trim()).toList();
        }

        final List<List<String>> table = rows
            .where((String row) => !isSeparator(row))
            .map(cells)
            .where((List<String> row) => row.any((String cell) => cell.isNotEmpty))
            .toList();

        return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Table(
                border: TableBorder.all(
                    color: AppColors.n200,
                    borderRadius: AppRadius.all(AppRadius.xs),
                ),
                // The labels take what they need, up to 40%: at a large
                // system font the values still keep most of the width.
                columnWidths: const <int, TableColumnWidth>{
                    0: MinColumnWidth(IntrinsicColumnWidth(), FractionColumnWidth(0.4)),
                },
                children: <TableRow>[
                    for (final List<String> row in table)
                        TableRow(
                            children: <Widget>[
                                for (int c = 0; c < row.length; c++)
                                    Padding(
                                        padding: const EdgeInsets.all(AppSpacing.sm),
                                        child: Text.rich(
                                            TextSpan(
                                                children: _spans(
                                                    row[c],
                                                    c == 0 ? text.copyWith(color: AppColors.n600) : text,
                                                ),
                                            ),
                                        ),
                                    ),
                            ],
                        ),
                ],
            ),
        );
    }

    /// [text] as spans in [style], with its bold, code and links resolved.
    List<InlineSpan> _spans(String text, TextStyle style) {
        final List<InlineSpan> spans = <InlineSpan>[];
        int at = 0;

        for (final RegExpMatch match in _inline.allMatches(text)) {
            if (match.start > at) {
                spans.add(TextSpan(text: text.substring(at, match.start), style: style));
            }
            if (match[1] != null) {
                spans.addAll(_spans(match[1]!, AppText.weight(style, 700)));
            } else if (match[2] != null) {
                // Only ever a host name in the documents; it reads as text.
                spans.add(TextSpan(text: match[2], style: style));
            } else {
                spans.add(
                    TextSpan(
                        text: match[3] ?? match[5],
                        style: style.copyWith(
                            color: AppColors.brand500,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.brand500,
                        ),
                        recognizer: _linkTo(match[4] ?? match[5]!),
                    ),
                );
            }
            at = match.end;
        }

        if (at < text.length) spans.add(TextSpan(text: text.substring(at), style: style));
        return spans;
    }

    TapGestureRecognizer _linkTo(String target) {
        final TapGestureRecognizer link = TapGestureRecognizer()..onTap = () => _open(target);
        _links.add(link);
        return link;
    }

    /// Another document opens here, on top of this one, from the same
    /// language's folder; anything else is a web address and goes to the
    /// browser.
    void _open(String target) {
        if (!target.endsWith('.md')) {
            Legal.open(target);
            return;
        }

        final String folder = widget.asset.substring(0, widget.asset.lastIndexOf('/') + 1);
        Navigator.of(context).push(
            CupertinoPageRoute<void>(
                builder: (BuildContext context) => LegalDocumentPage(
                    asset: folder + target.replaceFirst('./', ''),
                ),
            ),
        );
    }
}
