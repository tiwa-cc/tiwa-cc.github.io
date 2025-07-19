import 'package:flutter/material.dart';
import 'package:my_portfolio/app/app_bar_logo.dart';
import 'package:my_portfolio/app/section.dart';
import 'package:my_portfolio/features/about/about_panel.dart';
import 'package:my_portfolio/features/about/about_view_button.dart';
import 'package:my_portfolio/features/contact/contact_panel.dart';
import 'package:my_portfolio/features/contact/contact_view_button.dart';
import 'package:my_portfolio/features/header/header_view.dart';
import 'package:my_portfolio/features/portfolio/portfolio_panel.dart';
import 'package:my_portfolio/features/portfolio/portfolio_view_button.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/res/asset_header_bg.dart';
import 'package:my_portfolio/res/asset_subtitle.dart';
import 'package:my_portfolio/res/asset_title.dart';
import 'package:my_portfolio/shared/themes/app_theme_data.dart';

class TopView extends StatefulWidget {
  const TopView({super.key});

  @override
  State<TopView> createState() => _TopViewState();
}

class _TopViewState extends State<TopView> {
  final _scrollController = ScrollController();
  final _sectionKeys = <Section, GlobalKey>{};

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_handleScroll);

    for (final section in Section.values) {
      _sectionKeys[section] = GlobalKey();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final mediaQuery = MediaQuery.of(context);

    return MaterialApp(
      title: l10n.title,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      theme: AppThemeData.themeData,
      home: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            HeaderView(
              key: _sectionKeys[Section.header],
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
              child: Column(
                children: [
                  Column(
                    children: [
                      Text("Hello world ${mediaQuery.size.width}"),
                      AboutPanel(
                        key: _sectionKeys[Section.about],
                        onHeader: _scrollViewHeader,
                      ),
                      PortfolioPanel(key: _sectionKeys[Section.portfolio]),
                      ContactPanel(key: _sectionKeys[Section.contact]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleScroll() {
    for (final entry in _sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        final pos = box.localToGlobal(Offset.zero).dy;
        if (pos < 200 && pos > -200) {
          // widget.onSectionChanged(entry.key);
          break;
        }
      }
    }
  }

  void scrollTo(Section section) {
    final key = _sectionKeys[section];
    final ctx = key?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollViewHeader() {
    scrollTo(Section.header);
  }

  void _scrollViewAbout() {
    scrollTo(Section.about);
  }

  void _scrollViewPortfolio() {
    scrollTo(Section.portfolio);
  }

  void _scrollViewContact() {
    scrollTo(Section.contact);
  }
}
