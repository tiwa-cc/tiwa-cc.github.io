import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/widgets/card_title.dart';
import 'package:my_portfolio/shared/widgets/icon_label.dart';
import 'package:my_portfolio/shared/widgets/scroll_to_head_button.dart';

final class SoftwareSkillsPanel extends StatelessWidget {
  const SoftwareSkillsPanel({super.key, required this.onHeader});

  final VoidCallback onHeader;
  final iconSize = 48.0;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final title = l10n.softwareSkillTitle;
    final skills = {
      FontAwesomeIcons.docker: 'Docker',
      FontAwesomeIcons.github: 'GitHub',
      FontAwesomeIcons.android: 'Android',
      FontAwesomeIcons.java: 'Java',
      FontAwesomeIcons.python: 'Python',
      FontAwesomeIcons.linux: 'Linux',
      FontAwesomeIcons.windows: 'Windows',
      FontAwesomeIcons.gitlab: 'GitLab',
      FontAwesomeIcons.aws: 'AWS',
      FontAwesomeIcons.bootstrap: 'Bootstrap',
      FontAwesomeIcons.centos: 'CentOS',
      FontAwesomeIcons.css3: 'CSS',
      FontAwesomeIcons.dartLang: 'Dart',
      FontAwesomeIcons.debian: 'Debian',
      FontAwesomeIcons.flutter: 'Flutter',
      FontAwesomeIcons.fontAwesome: "Font\nAwesome",
      FontAwesomeIcons.gitAlt: 'Git',
      FontAwesomeIcons.jenkins: 'Jenkins',
      FontAwesomeIcons.jira: 'Jira',
      FontAwesomeIcons.js: 'JavaScript',
      FontAwesomeIcons.laravel: 'Laravel',
      FontAwesomeIcons.markdown: 'Markdown',
      // FontAwesomeIcons.notion: 'Notion',
      FontAwesomeIcons.php: 'PHP',
      FontAwesomeIcons.raspberryPi: 'RasPi',
      FontAwesomeIcons.swift: 'Swift',
      FontAwesomeIcons.symfony: 'Symfony',
      FontAwesomeIcons.ubuntu: 'Ubuntu',
    };
    final columnSizeCount = 4;
    final rowSizeCount = skills.length / columnSizeCount;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScrollToHeadButton(onHeader: onHeader),
        CardTitle(title: title),
        LayoutGrid(
          columnSizes: List.filled(columnSizeCount, 1.fr),
          rowSizes: List.filled(rowSizeCount.ceil(), auto),
          columnGap: 2,
          rowGap: 16.0,
          children: skills.entries
              .map(
                (entry) => IconLabel(
                  icon: entry.key,
                  title: entry.value,
                  size: iconSize,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
