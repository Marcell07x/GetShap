import 'package:flutter/material.dart';

/// A tip cut to [maxLines] lines on its card, ending in "…" whenever more of
/// it follows.
///
/// Text's own "…" does not ask whether more follows, only whether the last
/// line shown wraps: a tip cut on one of its line breaks got no "…", and the
/// blank line between two paragraphs could be the last line on the card.
class CutTipText extends StatelessWidget {
    final String tip;
    final int maxLines;
    final TextStyle style;

    const CutTipText(this.tip, {super.key, required this.maxLines, required this.style});

    @override
    Widget build(BuildContext context) {
        // How much fits depends on the card's width.
        return LayoutBuilder(
            builder: (context, constraints) => Text(
                _cut(context, constraints.maxWidth),
                maxLines: maxLines,
                style: style,
            ),
        );
    }

    String _cut(BuildContext context, double width) {
        // Measured the way Text lays it out; nothing here is drawn.
        TextStyle effective = DefaultTextStyle.of(context).style.merge(style);
        if (MediaQuery.boldTextOf(context)) {
            effective = effective.merge(const TextStyle(fontWeight: FontWeight.bold));
        }
        final TextPainter painter = TextPainter(
            maxLines: maxLines,
            textDirection: Directionality.of(context),
            textScaler: MediaQuery.textScalerOf(context),
            locale: Localizations.maybeLocaleOf(context),
        );
        // False when more would follow the last line.
        bool fits(String text) {
            painter
                ..text = TextSpan(text: text, style: effective)
                ..layout(maxWidth: width);
            return !painter.didExceedMaxLines;
        }

        String shown = tip;
        if (!fits(tip)) {
            // More follows: the longest start of the tip that still fits
            // with its "…".
            int low = 0;
            int high = tip.length;
            while (low < high) {
                final int mid = (low + high + 1) ~/ 2;
                if (fits(_withEllipsis(tip.substring(0, mid)))) {
                    low = mid;
                } else {
                    high = mid - 1;
                }
            }
            shown = _withEllipsis(tip.substring(0, low));
        }
        painter.dispose();
        return shown;
    }

    /// [start] and "…", without the blank lines and spaces before the cut,
    /// and "lábizmok…" rather than "lábizmok.…".
    static String _withEllipsis(String start) {
        String cut = start.trimRight();
        if (cut.endsWith('.')) cut = cut.substring(0, cut.length - 1);
        return '$cut…';
    }
}
