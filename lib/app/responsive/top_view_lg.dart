import 'package:flutter/material.dart';
import 'package:my_portfolio/app/responsive/top_view_holder.dart';
import 'package:my_portfolio/app/section.dart';

class TopViewLg extends StatelessWidget {
  final TopViewHolder holder;
  const TopViewLg({super.key, required this.holder});

  static const _sectionGap = 12.0;

  @override
  Widget build(BuildContext context) {
    // +------------------+---------------------------+
    // | profile          | about                     |
    // +------------------+---------------------------+
    // | contents                                     |
    // +------------------+---------------------------+
    // | strengths        | capability                |
    // +------------------+---------------------------+
    // | background                                   |
    // +------------------+---------------------------+
    // | contact                                      |
    // +------------------+---------------------------+
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: holder.getCard(Section.profile)),
            const SizedBox(width: _sectionGap),
            Expanded(child: holder.getCard(Section.about)),
          ],
        ),
        const SizedBox(height: _sectionGap),
        holder.getCard(Section.contents),
        const SizedBox(height: _sectionGap),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: holder.getCard(Section.coreSkills)),
            const SizedBox(width: _sectionGap),
            Expanded(child: holder.getCard(Section.softwareSkills)),
          ],
        ),
        const SizedBox(height: _sectionGap),
        holder.getCard(Section.experience),
        const SizedBox(height: _sectionGap),
        holder.getCard(Section.contact),
      ],
    );
  }
}
