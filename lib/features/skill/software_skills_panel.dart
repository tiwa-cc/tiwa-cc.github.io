import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/domain/software_skill.dart';
import 'package:my_portfolio/features/skill/software_skill_presenter.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/providers.dart';
import 'package:my_portfolio/shared/widgets/card_title.dart';
import 'package:my_portfolio/shared/widgets/icon_label.dart';

final class SoftwareSkillsPanel extends ConsumerWidget {
  const SoftwareSkillsPanel({super.key});

  static const _primaryStackIds = [
    'web_frontend',
    'backend_api',
    'mobile_apps',
    'cloud_infrastructure',
    'data_storage',
  ];
  static const _deliveryToolingIds = [
    'development_tooling',
    'testing_quality',
    'documentation_workflow',
  ];
  static const _crossDomainIds = ['system_integration'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitle(title: l10n.softwareSkillTitle),
        const SizedBox(height: 12),
        ...ref
            .watch(softwareSkillListProvider)
            .when(
              data: (skills) {
                if (skills.isEmpty) {
                  return [
                    _SoftwareSkillStateMessage(
                      message: l10n.softwareSkillEmptyMessage,
                    ),
                  ];
                }

                final sections = _buildSnapshotSections(skills, l10n);
                return [_CapabilitySnapshot(sections: sections)];
              },
              error: (e, stack) => [
                _SoftwareSkillStateMessage(
                  message: l10n.softwareSkillLoadError,
                ),
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

  List<SoftwareSkillSectionPresentation> _buildSnapshotSections(
    List<SoftwareSkill> skills,
    L10n l10n,
  ) {
    final skillById = {for (final skill in skills) skill.id: skill};
    final usedIds = <String>{};

    List<SoftwareSkill> pick(List<String> ids) {
      final picked = <SoftwareSkill>[];
      for (final id in ids) {
        final skill = skillById[id];
        if (skill == null) {
          continue;
        }
        picked.add(skill);
        usedIds.add(id);
      }
      return picked;
    }

    final sections = <SoftwareSkillSectionPresentation>[
      SoftwareSkillPresenter.buildSection(
        title: l10n.softwareSkillPrimaryLabel,
        skills: pick(_primaryStackIds),
      ),
      SoftwareSkillPresenter.buildSection(
        title: l10n.softwareSkillDeliveryLabel,
        skills: pick(_deliveryToolingIds),
      ),
      SoftwareSkillPresenter.buildSection(
        title: l10n.softwareSkillCrossDomainLabel,
        skills: pick(_crossDomainIds),
      ),
    ];

    final additionalSkills = skills
        .where((skill) => !usedIds.contains(skill.id))
        .toList(growable: false);
    if (additionalSkills.isNotEmpty) {
      sections.add(
        SoftwareSkillPresenter.buildSection(
          title: l10n.softwareSkillAdditionalLabel,
          skills: additionalSkills,
        ),
      );
    }

    return sections
        .where(
          (section) =>
              section.iconSkills.isNotEmpty ||
              section.textOnlySkillLabels.isNotEmpty,
        )
        .toList(growable: false);
  }
}

final class _CapabilitySnapshot extends StatelessWidget {
  const _CapabilitySnapshot({required this.sections});

  final List<SoftwareSkillSectionPresentation> sections;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final useTwoColumns = constraints.maxWidth >= 760;
        final cardWidth = useTwoColumns
            ? (constraints.maxWidth - spacing) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: sections
              .map(
                (section) => SizedBox(
                  width: cardWidth,
                  child: _SoftwareSkillSection(section: section),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

final class _SoftwareSkillSection extends StatelessWidget {
  const _SoftwareSkillSection({required this.section});

  final SoftwareSkillSectionPresentation section;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(
      context,
    ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700);
    final children = <Widget>[];

    if (section.title case final title?) {
      children.add(Text(title, style: titleStyle));
    }
    if (section.iconSkills.isNotEmpty) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: 12));
      }
      children.add(
        _SoftwareSkillsGrid(
          skills: section.iconSkills,
          iconSize: 40,
          columnCount: 4,
        ),
      );
    }
    if (section.textOnlySkillLabels.isNotEmpty) {
      if (children.isNotEmpty) {
        children.add(SizedBox(height: section.iconSkills.isEmpty ? 8 : 12));
      }
      children.add(
        _SoftwareSkillsTextList(labels: section.textOnlySkillLabels),
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

final class _SoftwareSkillsGrid extends StatelessWidget {
  const _SoftwareSkillsGrid({
    required this.skills,
    required this.iconSize,
    required this.columnCount,
  });

  final List<SoftwareSkillIconPresentation> skills;
  final double iconSize;
  final int columnCount;

  @override
  Widget build(BuildContext context) {
    final effectiveColumnCount = columnCount > skills.length
        ? skills.length
        : columnCount;
    final rowSizeCount = (skills.length / effectiveColumnCount).ceil();

    return SizedBox(
      width: double.infinity,
      child: LayoutGrid(
        columnSizes: List.filled(effectiveColumnCount, 1.fr),
        rowSizes: List.filled(rowSizeCount, auto),
        columnGap: 8.0,
        rowGap: 16.0,
        children: skills
            .map(
              (skill) => IconLabel(
                icon: skill.icon,
                title: skill.label,
                semanticLabel: skill.label,
                size: iconSize,
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

final class _SoftwareSkillsTextList extends StatelessWidget {
  const _SoftwareSkillsTextList({required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      labels.join(' / '),
      style: textTheme.bodyMedium?.copyWith(height: 1.5),
    );
  }
}

class _SoftwareSkillStateMessage extends StatelessWidget {
  const _SoftwareSkillStateMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
