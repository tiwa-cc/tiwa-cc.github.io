import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/app/app_bar_logo.dart';
import 'package:my_portfolio/app/layout_width_dropdown_button.dart';
import 'package:my_portfolio/app/locale_toggle_button.dart';
import 'package:my_portfolio/app/portfolio_load_coordinator.dart';
import 'package:my_portfolio/app/portfolio_load_error_view.dart';
import 'package:my_portfolio/app/responsive/top_view_holder.dart';
import 'package:my_portfolio/app/responsive/top_view_responsive.dart';
import 'package:my_portfolio/app/section.dart';
import 'package:my_portfolio/features/footer/footer_view.dart';
import 'package:my_portfolio/features/header/header_view.dart';
import 'package:my_portfolio/features/header/section_view_button.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/res/asset_header_bg.dart';
import 'package:my_portfolio/res/asset_subtitle.dart';
import 'package:my_portfolio/res/asset_title.dart';
import 'package:my_portfolio/shared/parts/scroll_jumper.dart';
import 'package:my_portfolio/shared/providers.dart';
import 'package:my_portfolio/shared/themes/app_theme_data.dart';
import 'package:my_portfolio/shared/widgets/app_route_aware.dart';
import 'package:my_portfolio/shared/widgets/breakpoint_observer.dart';
import 'package:my_portfolio/shared/widgets/layout_width_frame.dart';

Map<Section, GlobalKey> resolveSectionGlobalKeys(
  Iterable<Section> sections,
  GlobalKey Function(Section section) keyOf,
) {
  return Map<Section, GlobalKey>.fromEntries(
    sections.map((section) => MapEntry(section, keyOf(section))),
  );
}

class TopView extends ConsumerStatefulWidget {
  const TopView({super.key});

  @override
  ConsumerState<TopView> createState() => _TopViewState();
}

class _TopViewState extends ConsumerState<TopView> with ScrollJumper<Section> {
  static const _loadCoordinator = PortfolioLoadCoordinator();
  var _loadPhase = PortfolioLoadPhase.idle;
  int _loadRequestId = 0;
  var _initialLoadScheduled = false;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _initialLoadScheduled) {
        return;
      }
      _initialLoadScheduled = true;
      unawaited(_loadPortfolioData());
    });
  }

  @override
  void dispose() {
    disposeScrollJumper();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(breakpointSizeProvider.select((p) => p.size), (_, _) {
      cacheSectionOffsets();
    });
    ref.listen(activeLocaleProvider, (previous, next) {
      if (previous?.languageCode == next.languageCode) {
        return;
      }
      unawaited(_loadPortfolioData());
    });

    final locale = ref.watch(localeOverrideProvider);
    final topViewHolder = TopViewHolder(
      sectionGlobalKeys: resolveSectionGlobalKeys(
        Section.values,
        (section) => globalKeyWithSection(section)!,
      ),
      scrollViewHeader: scrollToTop,
    );
    final navigationActions = visibleNavigationSections()
        .map(
          (section) => SectionViewButton(
            section: section,
            onPressed: () => scrollToSection(section),
          ),
        )
        .toList(growable: false);
    final utilityActions = [
      const LayoutWidthDropdownButton(),
      const LocaleToggleButton(),
    ];

    return MaterialApp(
      onGenerateTitle: (context) => L10n.of(context).brandName,
      debugShowCheckedModeBanner: false,
      locale: locale,
      localeListResolutionCallback: L10n.resolveLocaleList,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      theme: AppThemeData.themeData,
      navigatorObservers: [ref.watch(routeObserverProvider)],
      home: AppRouteAware(
        child: Scaffold(
          body: LayoutWidthFrame(
            child: Stack(
              children: [
                BreakpointObserver(),
                CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    HeaderView(
                      background: AssetHeaderBg(),
                      navLogo: const AppBarLogo(),
                      title: AssetTitle(),
                      subtitle: AssetSubtitle(),
                      navigationActions: navigationActions,
                      utilityActions: utilityActions,
                    ),
                    SliverToBoxAdapter(
                      child: TopViewResponsive(holder: topViewHolder),
                    ),
                    SliverToBoxAdapter(child: FooterView()),
                  ],
                ),
                if (_loadPhase == PortfolioLoadPhase.failed)
                  Positioned.fill(
                    child: PortfolioLoadErrorView(
                      onRetry: () {
                        unawaited(_loadPortfolioData());
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadPortfolioData() async {
    final requestId = ++_loadRequestId;
    if (mounted) {
      setState(() {
        _loadPhase = PortfolioLoadPhase.loading;
      });
    }

    try {
      await _loadCoordinator.load([
        () async {
          await ref.read(aboutControllerProvider).index();
        },
        () async {
          await ref.read(contentControllerProvider).index();
        },
        () async {
          await ref.read(coreSkillControllerProvider).index();
        },
        () async {
          await ref.read(softwareSkillControllerProvider).index();
        },
        () async {
          await ref.read(experienceControllerProvider).index();
        },
      ]);

      if (!mounted || requestId != _loadRequestId) {
        return;
      }
      setState(() {
        _loadPhase = PortfolioLoadPhase.ready;
      });
    } catch (_) {
      if (!mounted || requestId != _loadRequestId) {
        return;
      }
      setState(() {
        _loadPhase = PortfolioLoadPhase.failed;
      });
    }
  }
}
