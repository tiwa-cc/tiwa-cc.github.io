import 'package:flutter/material.dart';
import 'package:my_portfolio/app/responsive/top_view_holder.dart';
import 'package:my_portfolio/features/about/about_panel.dart';
import 'package:my_portfolio/features/contact/contact_panel.dart';
import 'package:my_portfolio/features/portfolio/portfolio_panel.dart';
import 'package:my_portfolio/features/profile/profile_panel.dart';
import 'package:my_portfolio/features/skill/core_skill_panel.dart';

class TopViewMd extends StatelessWidget {
  final TopViewHolder holder;
  const TopViewMd({super.key, required this.holder});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: ProfilePanel(
            key: holder.aboutGlobalKey,
            onHeader: holder.scrollViewHeader,
          ),
        ),
        Flexible(
          flex: 1,
          child: CoreSkillPanel(
            key: holder.aboutGlobalKey,
            onHeader: holder.scrollViewHeader,
          ),
        ),
        Flexible(
          flex: 1,
          child: AboutPanel(
            key: holder.aboutGlobalKey,
            onHeader: holder.scrollViewHeader,
          ),
        ),
        Flexible(
          flex: 1,
          child: PortfolioPanel(
            key: holder.portfolioGlobalKey,
            onHeader: holder.scrollViewHeader,
          ),
        ),
        Flexible(
          flex: 1,
          child: ContactPanel(
            key: holder.contactGlobalKey,
            onHeader: holder.scrollViewHeader,
          ),
        ),
      ],
    );
  }
}
