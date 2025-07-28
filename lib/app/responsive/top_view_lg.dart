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

class TopViewLg extends StatelessWidget {
  final TopViewHolder holder;
  const TopViewLg({super.key, required this.holder});

  @override
  Widget build(BuildContext context) {
    // +---------+-------------------------------------+
    // | profile | about                               |
    // |         |                                     |
    // | Contact +------------------+------------------+
    // |         | Education        | Core Skills      |
    // |         |                  |                  |
    // |         | Experience       | Software Skills  |
    // |         |                  |                  |
    // +---------+------------------+------------------+
    return LayoutGrid(
      areas: [
        ['left', 'center_above', 'center_above'],
        ['left', 'center_left', 'center_right'],
      ].map((row) => row.join(' ')).join('\n'),
      columnSizes: [1.fr, 2.fr, 2.fr],
      rowSizes: [120.0.px, auto],
      columnGap: 12,
      rowGap: 12,
      children: [
        Column(
          children: [
            SizedBox(height: 32.0),
            profileCard(),
            SizedBox(height: 32.0),
            contactCard(),
          ],
        ).inGridArea('left'),
        ...[
          aboutCard().inGridArea('center_above'),
          Column(
            children: [
              educationCard(),
              SizedBox(height: 32.0),
              experienceCard(),
            ],
          ).inGridArea('center_left'),
          Column(
            children: [
              coreSkillsCard(),
              SizedBox(height: 32.0),
              softwareSkillsCard(),
            ],
          ).inGridArea('center_right'),
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
