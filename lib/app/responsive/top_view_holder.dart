import 'package:flutter/material.dart';
import 'package:my_portfolio/app/section.dart';
import 'package:my_portfolio/features/about/about_panel.dart';
import 'package:my_portfolio/features/contact/contact_panel.dart';
import 'package:my_portfolio/features/contents/contents_panel.dart';
import 'package:my_portfolio/features/experience/experience_panel.dart';
import 'package:my_portfolio/features/profile/profile_panel.dart';
import 'package:my_portfolio/features/skill/core_skill_panel.dart';
import 'package:my_portfolio/features/skill/software_skills_panel.dart';

final class TopViewHolder {
  final Map<Section, GlobalKey> sectionGlobalKeys;
  final Function() scrollViewHeader;

  const TopViewHolder({
    required this.sectionGlobalKeys,
    required this.scrollViewHeader,
  });
}

extension TopViewHolderExt on TopViewHolder {
  Widget getCard(Section section) {
    final Widget widget;
    final key = sectionGlobalKeys[section];
    switch (section) {
      case Section.about:
        widget = AboutPanel(key: key);
      case Section.profile:
        widget = ProfilePanel(key: key);
      case Section.contact:
        widget = ContactPanel(key: key);
      case Section.experience:
        widget = ExperiencePanel(key: key);
      case Section.coreSkills:
        widget = CoreSkillPanel(key: key);
      case Section.softwareSkills:
        widget = SoftwareSkillsPanel(key: key);
      case Section.contents:
        widget = ContentsPanel(key: key);
      case Section.flutterWebContent:
        widget = SizedBox.shrink(key: key);
    }
    return widget;
  }
}
