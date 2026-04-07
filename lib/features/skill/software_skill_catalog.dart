import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final class SoftwareSkillVisual {
  const SoftwareSkillVisual({this.icon, required this.categoryId});

  final IconData? icon;
  final String categoryId;
}

final class SoftwareSkillCatalog {
  static const String developmentToolsCategoryId = 'development_tools';
  static const String languagesCategoryId = 'languages';
  static const String frameworksCategoryId = 'frameworks';
  static const String markupDocsCategoryId = 'markup_docs';
  static const String cloudInfrastructureCategoryId = 'cloud_infrastructure';
  static const String protocolsCategoryId = 'protocols';
  static const String platformsCategoryId = 'platforms';
  static const String otherCategoryId = 'other';

  static const Map<String, SoftwareSkillVisual> _visuals = {
    'web_frontend': SoftwareSkillVisual(
      icon: FontAwesomeIcons.code,
      categoryId: frameworksCategoryId,
    ),
    'backend_api': SoftwareSkillVisual(
      icon: FontAwesomeIcons.server,
      categoryId: frameworksCategoryId,
    ),
    'mobile_apps': SoftwareSkillVisual(
      icon: FontAwesomeIcons.mobileScreenButton,
      categoryId: platformsCategoryId,
    ),
    'cloud_infrastructure': SoftwareSkillVisual(
      icon: FontAwesomeIcons.cloud,
      categoryId: cloudInfrastructureCategoryId,
    ),
    'data_storage': SoftwareSkillVisual(
      icon: FontAwesomeIcons.database,
      categoryId: cloudInfrastructureCategoryId,
    ),
    'development_tooling': SoftwareSkillVisual(
      icon: FontAwesomeIcons.screwdriverWrench,
      categoryId: developmentToolsCategoryId,
    ),
    'testing_quality': SoftwareSkillVisual(
      icon: FontAwesomeIcons.shieldHalved,
      categoryId: developmentToolsCategoryId,
    ),
    'documentation_workflow': SoftwareSkillVisual(
      icon: FontAwesomeIcons.fileLines,
      categoryId: markupDocsCategoryId,
    ),
    'system_integration': SoftwareSkillVisual(
      icon: FontAwesomeIcons.shareNodes,
      categoryId: otherCategoryId,
    ),
  };

  static IconData? iconFor(String id) => _visuals[id]?.icon;

  static String categoryFor(String id) =>
      _visuals[id]?.categoryId ?? otherCategoryId;
}
