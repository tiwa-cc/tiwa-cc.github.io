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
      ...{
        FontAwesomeIcons.github: 'GitHub',
        FontAwesomeIcons.gitlab: 'GitLab',
        FontAwesomeIcons.docker: 'Docker',
        FontAwesomeIcons.jira: 'Jira',
        FontAwesomeIcons.jenkins: 'Jenkins',
      },
      ...{
        FontAwesomeIcons.flutter: 'Flutter',
        FontAwesomeIcons.dartLang: 'Dart',
        FontAwesomeIcons.android: 'Android',
        FontAwesomeIcons.java: 'Java',
        FontAwesomeIcons.swift: 'Swift',
        FontAwesomeIcons.python: 'Python',
      },
      ...{
        FontAwesomeIcons.laravel: 'Laravel',
        FontAwesomeIcons.symfony: 'Symfony',
        FontAwesomeIcons.php: 'PHP',
        FontAwesomeIcons.js: 'JavaScript',
      },
      ...{
        FontAwesomeIcons.bootstrap: 'Bootstrap',
        FontAwesomeIcons.css3: 'CSS',
        FontAwesomeIcons.fontAwesome: "Font\nAwesome",
        FontAwesomeIcons.markdown: 'Markdown',
      },
      ...{
        FontAwesomeIcons.aws: 'AWS',
        FontAwesomeIcons.gitAlt: 'Git',
        // FontAwesomeIcons.notion: 'Notion',
      },
      ...{
        FontAwesomeIcons.windows: 'Windows',
        FontAwesomeIcons.linux: 'Linux',
        FontAwesomeIcons.debian: 'Debian',
        FontAwesomeIcons.ubuntu: 'Ubuntu',
        FontAwesomeIcons.centos: 'CentOS',
        FontAwesomeIcons.raspberryPi: "RaspberryPi",
      },
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
