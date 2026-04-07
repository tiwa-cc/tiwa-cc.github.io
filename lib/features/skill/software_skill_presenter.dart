import 'package:flutter/widgets.dart';
import 'package:my_portfolio/domain/software_skill.dart';
import 'package:my_portfolio/features/skill/software_skill_catalog.dart';
import 'package:my_portfolio/l10n/l10n.dart';

final class SoftwareSkillIconPresentation {
  const SoftwareSkillIconPresentation({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

final class SoftwareSkillSectionPresentation {
  const SoftwareSkillSectionPresentation({
    this.title,
    required this.iconSkills,
    required this.textOnlySkillLabels,
  });

  final String? title;
  final List<SoftwareSkillIconPresentation> iconSkills;
  final List<String> textOnlySkillLabels;
}

final class SoftwareSkillPresenter {
  static const List<String> categoryOrder = [
    SoftwareSkillCatalog.developmentToolsCategoryId,
    SoftwareSkillCatalog.languagesCategoryId,
    SoftwareSkillCatalog.frameworksCategoryId,
    SoftwareSkillCatalog.markupDocsCategoryId,
    SoftwareSkillCatalog.cloudInfrastructureCategoryId,
    SoftwareSkillCatalog.protocolsCategoryId,
    SoftwareSkillCatalog.platformsCategoryId,
    SoftwareSkillCatalog.otherCategoryId,
  ];

  static SoftwareSkillSectionPresentation buildSection({
    String? title,
    required List<SoftwareSkill> skills,
  }) {
    final iconSkills = <SoftwareSkillIconPresentation>[];
    final textOnlySkillLabels = <String>[];

    for (final skill in skills) {
      final icon = SoftwareSkillCatalog.iconFor(skill.id);
      if (icon != null) {
        iconSkills.add(
          SoftwareSkillIconPresentation(icon: icon, label: skill.label),
        );
        continue;
      }
      textOnlySkillLabels.add(skill.label);
    }

    return SoftwareSkillSectionPresentation(
      title: title,
      iconSkills: iconSkills,
      textOnlySkillLabels: textOnlySkillLabels,
    );
  }

  static List<SoftwareSkillSectionPresentation> buildCategorizedSections(
    List<SoftwareSkill> skills,
    L10n l10n,
  ) {
    final grouped = <String, List<SoftwareSkill>>{};

    for (final skill in skills) {
      final categoryId = SoftwareSkillCatalog.categoryFor(skill.id);
      grouped.putIfAbsent(categoryId, () => <SoftwareSkill>[]).add(skill);
    }

    return categoryOrder
        .where((categoryId) => grouped.containsKey(categoryId))
        .map(
          (categoryId) => buildSection(
            title: titleForCategory(categoryId, l10n),
            skills: grouped[categoryId]!,
          ),
        )
        .toList(growable: false);
  }

  static String titleForCategory(String categoryId, L10n l10n) {
    switch (categoryId) {
      case SoftwareSkillCatalog.developmentToolsCategoryId:
        return l10n.softwareSkillCategoryDevelopmentTools;
      case SoftwareSkillCatalog.languagesCategoryId:
        return l10n.softwareSkillCategoryLanguages;
      case SoftwareSkillCatalog.frameworksCategoryId:
        return l10n.softwareSkillCategoryFrameworks;
      case SoftwareSkillCatalog.markupDocsCategoryId:
        return l10n.softwareSkillCategoryMarkupDocs;
      case SoftwareSkillCatalog.cloudInfrastructureCategoryId:
        return l10n.softwareSkillCategoryCloudInfrastructure;
      case SoftwareSkillCatalog.protocolsCategoryId:
        return l10n.softwareSkillCategoryProtocols;
      case SoftwareSkillCatalog.platformsCategoryId:
        return l10n.softwareSkillCategoryPlatforms;
      default:
        return l10n.softwareSkillCategoryOther;
    }
  }
}
