import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_portfolio/domain/content_entry.dart';
import 'package:url_launcher/url_launcher.dart';

final class ContentShowcase extends StatelessWidget {
  const ContentShowcase({super.key, required this.entries});

  final List<ContentEntry> entries;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final useTwoColumns = constraints.maxWidth >= 960;
        final cardWidth = useTwoColumns
            ? (constraints.maxWidth - spacing) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: entries
              .map(
                (entry) => SizedBox(
                  width: cardWidth,
                  child: _ContentEntryCard(entry: entry),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

final class _ContentEntryCard extends StatelessWidget {
  const _ContentEntryCard({required this.entry});

  final ContentEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final validLinks = entry.links
        .map((link) => (link: link, uri: Uri.tryParse(link.url)))
        .where((pair) => pair.uri != null)
        .toList(growable: false);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.title,
              style: theme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final tag in entry.tags)
                  Chip(
                    label: Text(tag),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              entry.summary,
              style: theme.bodyLarge?.copyWith(
                height: 1.55,
                color: colorScheme.onSurface,
              ),
            ),
            if (entry.details.isNotEmpty) const SizedBox(height: 16),
            ...entry.details.map(
              (detail) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _ContentDetailRow(detail: detail),
              ),
            ),
            if (validLinks.isNotEmpty) const SizedBox(height: 8),
            if (validLinks.isNotEmpty)
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: validLinks
                    .map(
                      (pair) =>
                          _ExternalLinkButton(link: pair.link, uri: pair.uri),
                    )
                    .toList(growable: false),
              ),
          ],
        ),
      ),
    );
  }
}

final class _ContentDetailRow extends StatelessWidget {
  const _ContentDetailRow({required this.detail});

  final String detail;

  @override
  Widget build(BuildContext context) {
    final parsed = _ParsedDetail.tryParse(detail);
    final theme = Theme.of(context).textTheme;

    if (parsed == null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• '),
          Expanded(
            child: Text(detail, style: theme.bodyMedium?.copyWith(height: 1.5)),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(
            parsed.label,
            style: theme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            parsed.body,
            style: theme.bodyMedium?.copyWith(height: 1.5),
          ),
        ),
      ],
    );
  }
}

final class _ParsedDetail {
  const _ParsedDetail({required this.label, required this.body});

  final String label;
  final String body;

  static _ParsedDetail? tryParse(String value) {
    for (final separator in [':', '：']) {
      final index = value.indexOf(separator);
      if (index <= 0 || index >= 18) {
        continue;
      }

      final label = value.substring(0, index).trim();
      final body = value.substring(index + 1).trim();
      if (label.isEmpty || body.isEmpty) {
        continue;
      }

      return _ParsedDetail(label: label, body: body);
    }

    return null;
  }
}

final class _ExternalLinkButton extends StatelessWidget {
  const _ExternalLinkButton({required this.link, required this.uri});

  final ContentLink link;
  final Uri? uri;

  @override
  Widget build(BuildContext context) {
    final currentUri = uri;
    if (currentUri == null) {
      return const SizedBox.shrink();
    }

    void onPressed() {
      unawaited(_launch(currentUri));
    }

    if (link.kind == 'live') {
      return FilledButton.tonalIcon(
        onPressed: onPressed,
        icon: const Icon(Icons.open_in_new),
        label: Text(link.label),
      );
    }

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(link.kind == 'source' ? Icons.code : Icons.link),
      label: Text(link.label),
    );
  }

  Future<void> _launch(Uri uri) async {
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }
}
