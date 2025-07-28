import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:my_portfolio/app/responsive/top_view_holder.dart';
import 'package:my_portfolio/features/about/about_panel.dart';
import 'package:my_portfolio/features/contact/contact_panel.dart';
import 'package:my_portfolio/features/education/education_panel.dart';
import 'package:my_portfolio/features/experience/experience_panel.dart';
import 'package:my_portfolio/features/profile/profile_panel.dart';
import 'package:my_portfolio/features/skill/core_skill_panel.dart';
import 'package:my_portfolio/features/skill/software_skills_panel.dart';

class TopViewXs extends StatelessWidget {
  final TopViewHolder holder;
  const TopViewXs({super.key, required this.holder});

  @override
  Widget build(BuildContext context) {
    // +------------------+
    // | profile          |
    // | Contact          |
    // | about            |
    // | Education        |
    // | Experience       |
    // | Core Skills      |
    // | Software Skills  |
    // +------------------+
    return LayoutGrid(
      columnSizes: [1.fr],
      rowSizes: [auto, auto, auto, auto, auto, auto, auto],
      columnGap: 12,
      rowGap: 12,
      children: [
        profileCard(),
        contactCard(),
        aboutCard(),
        educationCard(),
        experienceCard(),
        coreSkillsCard(),
        softwareSkillsCard(),
      ],
    );
  }

  Widget aboutCard() {
    return AboutPanel(
      key: holder.aboutGlobalKey,
      onHeader: holder.scrollViewHeader,
    );
  }

  Widget profileCard() {
    return ProfilePanel(
      key: holder.profileGlobalKey,
      onHeader: holder.scrollViewHeader,
    );
  }

  Widget contactCard() {
    return ContactPanel(
      key: holder.contactGlobalKey,
      onHeader: holder.scrollViewHeader,
    );
  }

  Widget educationCard() {
    return EducationPanel(
      // key: holder.skillGlobalKey,
      onHeader: holder.scrollViewHeader,
    );
  }

  Widget experienceCard() {
    return ExperiencePanel(
      // key: holder.aboutGlobalKey,
      onHeader: holder.scrollViewHeader,
    );
  }

  Widget coreSkillsCard() {
    return CoreSkillPanel(
      // key: holder.aboutGlobalKey,
      onHeader: holder.scrollViewHeader,
    );
  }

  Widget softwareSkillsCard() {
    return SoftwareSkillsPanel(
      // key: holder.aboutGlobalKey,
      onHeader: holder.scrollViewHeader,
    );
  }
}
