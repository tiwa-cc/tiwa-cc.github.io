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

class TopViewXl extends StatelessWidget {
  final TopViewHolder holder;
  const TopViewXl({super.key, required this.holder});

  @override
  Widget build(BuildContext context) {
    // +---------+-----------------------------------------------------------+
    // | profile | about                                                     |
    // |         |                                                           |
    // |         +------------------+-------------------+--------------------+
    // |         | Education        | Experience        | Core Skills        |
    // |         |                  |                   |                    |
    // |         |                  |                   |                    |
    // +---------+                  |                   +--------------------+
    // | Contact |                  |                   | Software Skills    |
    // |         |                  |                   |                    |
    // |         |                  |                   |                    |
    // +---------+------------------+-------------------+--------------------+
    return LayoutGrid(
      areas: [
        ['profile', 'about', 'about', 'about'],
        ['profile', 'education', 'experience', 'coreSkill'],
        ['contact', 'education', 'experience', 'softwareSkill'],
      ].map((row) => row.join(' ')).join('\n'),
      columnSizes: [1.fr, 1.fr, 1.fr, 1.fr],
      rowSizes: [
        120.0.px, // Row 0: profile + about
        auto, // Row 1: Education, Experience, Core Skills
        auto, // Row 2: Contact + Software Skills
      ],
      columnGap: 12,
      rowGap: 12,
      children: [
        ...[
          Column(
            children: [
              SizedBox(height: 32.0),
              profileCard(),
              SizedBox(height: 32.0),
              contactCard(),
            ],
          ).inGridArea('profile'),
        ],
        ...[
          aboutCard().inGridArea('about'),
          ...[
            educationCard().inGridArea('education'),
            experienceCard().inGridArea('experience'),
            ...[
              Column(
                children: [coreSkillsCard(), softwareSkillsCard()],
              ).inGridArea('coreSkill'),
            ],
          ],
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
