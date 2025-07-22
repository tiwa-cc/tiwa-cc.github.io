import 'package:flutter/material.dart';
import 'package:my_portfolio/app/app_bar_logo.dart';
import 'package:my_portfolio/app/responsive/top_view_holder.dart';
import 'package:my_portfolio/app/responsive/top_view_responsive.dart';
import 'package:my_portfolio/app/section.dart';
import 'package:my_portfolio/features/about/about_view_button.dart';
import 'package:my_portfolio/features/contact/contact_view_button.dart';
import 'package:my_portfolio/features/header/header_view.dart';
import 'package:my_portfolio/features/portfolio/portfolio_view_button.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/res/asset_header_bg.dart';
import 'package:my_portfolio/res/asset_subtitle.dart';
import 'package:my_portfolio/res/asset_title.dart';
import 'package:my_portfolio/shared/parts/scroll_jumper.dart';
import 'package:my_portfolio/shared/themes/app_theme_data.dart';
import 'package:my_portfolio/shared/widgets/breakpoint_observer.dart';

class TopView extends StatefulWidget {
  const TopView({super.key});

  @override
  State<TopView> createState() => _TopViewState();
}

class _TopViewState extends State<TopView> with ScrollJumper<Section> {
  @override
  void initState() {
    super.initState();
    initScrollJumper(Section.values, (section) {
      // /*
      for (var s in Section.values) {
        final state = globalKeyWithSection(s)?.currentState;
        if (s == section) {
          state?.activate();
        } else {
          state?.deactivate();
        }
      }
      // */
    });
  }

  @override
  void dispose() {
    disposeScrollJumper();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;

    return MaterialApp(
      title: l10n.brandName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      theme: AppThemeData.themeData,
      home: Scaffold(
        body: Stack(
          children: [
            BreakpointObserver(),
            CustomScrollView(
              controller: scrollController,
              slivers: [
                HeaderView(
                  background: AssetHeaderBg(),
                  navLogo: AppBarLogo(),
                  title: AssetTitle(),
                  subtitle: AssetSubtitle(),
                  actions: [
                    AboutViewButton(onPressed: _scrollViewAbout),
                    PortfolioViewButton(onPressed: _scrollViewPortfolio),
                    ContactViewButton(onPressed: _scrollViewContact),
                  ],
                ),
                SliverToBoxAdapter(
                  child: TopViewResponsive(
                    holder: TopViewHolder(
                      skillGlobalKey: globalKeyWithSection(Section.skill)!,
                      profileGlobalKey: globalKeyWithSection(Section.profile)!,
                      aboutGlobalKey: globalKeyWithSection(Section.about)!,
                      portfolioGlobalKey: globalKeyWithSection(
                        Section.portfolio,
                      )!,
                      contactGlobalKey: globalKeyWithSection(Section.contact)!,
                      scrollViewHeader: _scrollViewHeader,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _scrollViewHeader() {
    scrollToTop();
  }

  void _scrollViewAbout() {
    scrollToSection(Section.about);
  }

  void _scrollViewPortfolio() {
    scrollToSection(Section.portfolio);
  }

  void _scrollViewContact() {
    scrollToSection(Section.contact);
  }
}
