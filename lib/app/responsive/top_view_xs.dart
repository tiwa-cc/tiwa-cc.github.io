import 'package:flutter/material.dart';
import 'package:my_portfolio/app/responsive/top_view_holder.dart';
import 'package:my_portfolio/app/section.dart';
import 'package:my_portfolio/shared/widgets/scroll_to_head_button.dart';

class TopViewXs extends StatelessWidget {
  final TopViewHolder holder;
  const TopViewXs({super.key, required this.holder});

  static const _sectionsWithScrollJumper = <Section>{
    Section.profile,
    Section.contents,
    Section.coreSkills,
    Section.about,
    Section.softwareSkills,
    Section.experience,
    Section.contact,
  };

  static List<Section> orderedSections() => visibleNavigationSections();

  static bool showsScrollJumperAfter(Section section) {
    return _sectionsWithScrollJumper.contains(section);
  }

  @override
  Widget build(BuildContext context) {
    final sections = orderedSections();

    // +------------------+
    // | Profile          |
    // | Contents         |
    // | Core Skills      |
    // | About            |
    // | Software Skills  |
    // | Experience       |
    // | Contact          |
    // +------------------+
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12.0,
      children: [
        for (final section in sections) ...[
          holder.getCard(section),
          if (showsScrollJumperAfter(section))
            ScrollToHeadButton(onHeader: holder.scrollViewHeader),
        ],
      ],
    );
  }
}
