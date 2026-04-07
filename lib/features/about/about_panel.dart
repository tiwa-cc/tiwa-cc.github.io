import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/domain/about.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/providers.dart';
import 'package:my_portfolio/shared/widgets/card_title.dart';

class AboutPanel extends ConsumerWidget {
  const AboutPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final replacements = <String, String>{'username': l10n.author};

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitle(title: l10n.aboutTitle),
        const SizedBox(height: 12),
        ...ref
            .watch(aboutProvider)
            .when(
              data: (about) {
                if (about.isEmpty) {
                  return [_AboutStateMessage(message: l10n.aboutEmptyMessage)];
                }

                return [
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildParagraphs(
                          context,
                          about,
                          replacements,
                        ),
                      ),
                    ),
                  ),
                ];
              },
              error: (e, stack) => [
                _AboutStateMessage(message: l10n.aboutLoadError),
              ],
              loading: () => const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
              ],
            ),
      ],
    );
  }

  List<Widget> _buildParagraphs(
    BuildContext context,
    About about,
    Map<String, String> replacements,
  ) {
    final paragraphStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(height: 1.55);
    final paragraphs = about.paragraphs
        .map((paragraph) => paragraph.trim())
        .where((paragraph) => paragraph.isNotEmpty)
        .toList(growable: false);

    return List<Widget>.generate(paragraphs.length, (index) {
      final paragraph = paragraphs[index];
      return Padding(
        padding: EdgeInsets.only(
          bottom: index == paragraphs.length - 1 ? 0 : 12,
        ),
        child: Text.rich(
          TextSpan(
            style: paragraphStyle,
            children: _buildParagraphSpans(
              paragraph,
              replacements,
              paragraphStyle,
            ),
          ),
        ),
      );
    }, growable: false);
  }

  List<InlineSpan> _buildParagraphSpans(
    String paragraph,
    Map<String, String> replacements,
    TextStyle? baseStyle,
  ) {
    final tokenPattern = RegExp(r'{{\s*([a-zA-Z0-9_]+)\s*}}');
    final spans = <InlineSpan>[];
    var current = 0;

    for (final match in tokenPattern.allMatches(paragraph)) {
      if (match.start > current) {
        spans.add(TextSpan(text: paragraph.substring(current, match.start)));
      }

      final key = match.group(1);
      final rawToken = match.group(0) ?? '';
      final resolved = key == null ? null : replacements[key];

      spans.add(
        TextSpan(
          text: resolved ?? rawToken,
          style: resolved == null
              ? null
              : baseStyle?.copyWith(fontWeight: FontWeight.bold),
        ),
      );
      current = match.end;
    }

    if (current < paragraph.length) {
      spans.add(TextSpan(text: paragraph.substring(current)));
    }

    if (spans.isEmpty) {
      spans.add(TextSpan(text: paragraph));
    }

    return spans;
  }
}

class _AboutStateMessage extends StatelessWidget {
  const _AboutStateMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
