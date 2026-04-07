import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/features/contents/content_showcase.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/providers.dart';
import 'package:my_portfolio/shared/widgets/card_title.dart';

class ContentsPanel extends ConsumerWidget {
  const ContentsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitle(title: l10n.contentsTitle),
        ...ref
            .watch(contentEntryListProvider)
            .when(
              data: (entries) {
                if (entries.isEmpty) {
                  return [
                    _ContentsStateMessage(message: l10n.contentsEmptyMessage),
                  ];
                }

                return [
                  const SizedBox(height: 12),
                  ContentShowcase(entries: entries),
                ];
              },
              error: (e, stack) => [
                _ContentsStateMessage(message: l10n.contentsLoadError),
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
}

class _ContentsStateMessage extends StatelessWidget {
  const _ContentsStateMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
