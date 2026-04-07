import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/domain/core_skill.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/providers.dart';
import 'package:my_portfolio/shared/widgets/card_title.dart';

class CoreSkillPanel extends ConsumerWidget {
  const CoreSkillPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitle(title: l10n.coreSkillTitle),
        const SizedBox(height: 12),
        ...ref
            .watch(coreSkillListProvider)
            .when(
              data: (skills) {
                if (skills.isEmpty) {
                  return [
                    _CoreSkillStateMessage(message: l10n.coreSkillEmptyMessage),
                  ];
                }

                return [_CoreSkillGrid(skills: skills)];
              },
              error: (e, stack) => [
                _CoreSkillStateMessage(message: l10n.coreSkillLoadError),
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

final class _CoreSkillGrid extends StatelessWidget {
  const _CoreSkillGrid({required this.skills});

  final List<CoreSkill> skills;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final useTwoColumns = constraints.maxWidth >= 720;
        final cardWidth = useTwoColumns
            ? (constraints.maxWidth - spacing) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List<Widget>.generate(skills.length, (index) {
            return SizedBox(
              width: cardWidth,
              child: _CoreSkillCard(skill: skills[index], index: index),
            );
          }),
        );
      },
    );
  }
}

final class _CoreSkillCard extends StatelessWidget {
  const _CoreSkillCard({required this.skill, required this.index});

  final CoreSkill skill;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indexStyle = theme.textTheme.labelMedium?.copyWith(
      color: theme.colorScheme.primary,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
    );
    final titleStyle = theme.textTheme.titleMedium?.copyWith(
      height: 1.35,
      fontWeight: FontWeight.w700,
    );
    final descriptionStyle = theme.textTheme.bodyMedium?.copyWith(
      height: 1.55,
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${index + 1}'.toString().padLeft(2, '0'), style: indexStyle),
            const SizedBox(height: 10),
            Text(skill.title, style: titleStyle),
            const SizedBox(height: 10),
            Text(skill.description, style: descriptionStyle),
          ],
        ),
      ),
    );
  }
}

class _CoreSkillStateMessage extends StatelessWidget {
  const _CoreSkillStateMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
