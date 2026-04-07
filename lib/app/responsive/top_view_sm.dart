import 'package:flutter/material.dart';
import 'package:my_portfolio/app/responsive/top_view_holder.dart';
import 'package:my_portfolio/app/responsive/top_view_xs.dart';
import 'package:my_portfolio/app/section.dart';
import 'package:my_portfolio/shared/widgets/scroll_to_head_button.dart';

class TopViewSm extends StatelessWidget {
  final TopViewHolder holder;
  const TopViewSm({super.key, required this.holder});

  @override
  Widget build(BuildContext context) {
    final sections = visibleNavigationSections();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16.0,
      children: [
        for (final section in sections) ...[
          holder.getCard(section),
          if (TopViewXs.showsScrollJumperAfter(section))
            ScrollToHeadButton(onHeader: holder.scrollViewHeader),
        ],
      ],
    );
  }
}
