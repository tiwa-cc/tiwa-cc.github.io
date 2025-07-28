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

class TopViewSm extends StatelessWidget {
  final TopViewHolder holder;
  const TopViewSm({super.key, required this.holder});

  @override
  Widget build(BuildContext context) {
    // +------------+------------+
    // | profile    | about      |
    // |            +------------+
    // |            | Contact    |
    // +------------+------------+
    // | Education  | Experience |
    // +------------+------------+
    // | Core Skill | SW Skills  |
    // +------------+------------+
    const double gap = 12.0;
    return LayoutGrid(
      areas: [
        ['left_above', 'top_above'],
        ['left_above', 'top'],
        ['left', 'center'],
        ['left_below', 'center_below'],
      ].map((row) => row.join(' ')).join('\n'),
      columnSizes: [1.fr, 1.fr],
      rowSizes: [auto, auto, auto, auto],
      columnGap: gap,
      rowGap: gap,
      children: [
        ...[
          profileCard().inGridArea('left_above'),
          educationCard().inGridArea('left'),
          coreSkillsCard().inGridArea('left_below'),
        ],
        ...[
          aboutCard().inGridArea('top_above'),
          contactCard().inGridArea('top'),
          experienceCard().inGridArea('center'),
          softwareSkillsCard().inGridArea('center_below'),
        ],
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
      isListTile: false,
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
