import 'package:flutter/material.dart';
import 'package:my_portfolio/app/responsive/top_view_holder.dart';
import 'package:my_portfolio/features/about/about_panel.dart';
import 'package:my_portfolio/features/contact/contact_panel.dart';
import 'package:my_portfolio/features/portfolio/portfolio_panel.dart';

class TopViewXs extends StatelessWidget {
  final TopViewHolder holder;
  const TopViewXs({super.key, required this.holder});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AboutPanel(
          key: holder.aboutGlobalKey,
          onHeader: holder.scrollViewHeader,
        ),
        PortfolioPanel(
          key: holder.portfolioGlobalKey,
          onHeader: holder.scrollViewHeader,
        ),
        ContactPanel(
          key: holder.contactGlobalKey,
          onHeader: holder.scrollViewHeader,
        ),
      ],
    );
  }
}
