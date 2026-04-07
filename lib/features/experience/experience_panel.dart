import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/domain/experience.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/providers.dart';
import 'package:my_portfolio/shared/widgets/card_title.dart';

class ExperiencePanel extends ConsumerWidget {
  const ExperiencePanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitle(title: l10n.experienceTitle),
        const SizedBox(height: 12),
        ...ref
            .watch(experienceListProvider)
            .when(
              data: (list) {
                final experiences = [...list]..sort(_compareExperiences);

                if (experiences.isEmpty) {
                  return [
                    _ExperienceStateMessage(
                      message: l10n.experienceEmptyMessage,
                    ),
                  ];
                }

                return [_ExperienceGrid(experiences: experiences, l10n: l10n)];
              },
              error: (e, stack) => [
                _ExperienceStateMessage(message: l10n.experienceLoadError),
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

  int _compareExperiences(Experience a, Experience b) {
    final endAt = b.endedAt.compareTo(a.endedAt);

    if (endAt != 0) {
      return endAt;
    }

    return b.startedAt.compareTo(a.startedAt);
  }
}

final class _ExperienceGrid extends StatelessWidget {
  const _ExperienceGrid({required this.experiences, required this.l10n});

  final List<Experience> experiences;
  final L10n l10n;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final useTwoColumns = constraints.maxWidth >= 920;
        final cardWidth = useTwoColumns
            ? (constraints.maxWidth - spacing) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: experiences
              .map(
                (experience) => SizedBox(
                  width: cardWidth,
                  child: _ExperienceCard(
                    experience: experience,
                    duration: _formatDuration(experience),
                  ),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }

  String _formatDuration(Experience experience) {
    final start = _formatDate(experience.startedAt);
    final end = _formatDate(experience.endedAt);
    final separator = l10n.dateRangeSeparator;

    if (start.isEmpty && end.isEmpty) {
      return '';
    }
    if (start.isEmpty) {
      return end;
    }
    if (end.isEmpty) {
      return '$start $separator ${l10n.experienceCurrentLabel}';
    }
    return '$start $separator $end';
  }

  String _formatDate(String value) {
    final trimmed = value.trim();
    final match = RegExp(r'^(\d{4})-(\d{2})(?:-\d{2})?$').firstMatch(trimmed);

    if (match == null) {
      return trimmed;
    }

    return '${match.group(1)}.${match.group(2)}';
  }
}

final class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.experience, required this.duration});

  final Experience experience;
  final String duration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
    );
    final summaryStyle = theme.textTheme.bodyLarge?.copyWith(height: 1.45);
    final detailStyle = theme.textTheme.bodyMedium?.copyWith(
      height: 1.5,
      color: theme.colorScheme.onSurfaceVariant,
    );

    final highlights = experience.highlights
        .map((highlight) => highlight.trim())
        .where((highlight) => highlight.isNotEmpty)
        .toList(growable: false);
    final technologies = experience.technologies
        .map((technology) => technology.trim())
        .where((technology) => technology.isNotEmpty)
        .toList(growable: false);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (duration.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  duration,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(experience.title, style: titleStyle),
            if (experience.summary.trim().isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(experience.summary, style: summaryStyle),
            ],
            if (highlights.isNotEmpty) const SizedBox(height: 14),
            ...highlights.map(
              (highlight) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(child: Text(highlight, style: detailStyle)),
                  ],
                ),
              ),
            ),
            if (technologies.isNotEmpty) const SizedBox(height: 8),
            if (technologies.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: technologies
                    .map(
                      (technology) => Chip(
                        label: Text(technology),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    )
                    .toList(growable: false),
              ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceStateMessage extends StatelessWidget {
  const _ExperienceStateMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
