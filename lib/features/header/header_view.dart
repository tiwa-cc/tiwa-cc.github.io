import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/features/header/header_background_style.dart';
import 'package:my_portfolio/features/header/header_motion.dart';
import 'package:my_portfolio/features/header/header_popup_menu.dart';
import 'package:my_portfolio/res/interfaces/image_interface.dart';
import 'package:my_portfolio/shared/parts/breakpoint.dart';
import 'package:my_portfolio/shared/providers.dart';

class HeaderView extends ConsumerWidget {
  final ImageInterface background;
  final Widget? navLogo;
  final List<Widget> navigationActions;
  final List<Widget> utilityActions;
  final ImageInterface? title;
  final ImageInterface? subtitle;

  const HeaderView({
    super.key,
    required this.background,
    required this.navLogo,
    required this.navigationActions,
    required this.utilityActions,
    required this.title,
    required this.subtitle,
  });

  static List<Widget> resolveActions({
    required Breakpoint breakpoint,
    required List<Widget> navigationActions,
    required List<Widget> utilityActions,
  }) {
    return switch (breakpoint) {
      Breakpoint.xl => utilityActions,
      Breakpoint.lg => utilityActions,
      Breakpoint.md => utilityActions,
      Breakpoint.sm => [
        if (navigationActions.isNotEmpty)
          HeaderPopupMenu(actions: navigationActions),
        ...utilityActions,
      ],
      Breakpoint.xs => [
        if (navigationActions.isNotEmpty)
          HeaderPopupMenu(actions: navigationActions),
        ...utilityActions,
      ],
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(breakpointSizeProvider);
    final backgroundStyle = HeaderBackgroundStyle.resolve(responsive);
    final topPadding = MediaQuery.of(context).padding.top;
    final collapsedHeight = kToolbarHeight + topPadding;
    final preferredExpandedHeight = background.screenHeight(
      responsive.size.width,
    );
    final expandedHeight = preferredExpandedHeight > collapsedHeight
        ? preferredExpandedHeight
        : collapsedHeight + 1;
    final actions = resolveActions(
      breakpoint: responsive.breakpoint,
      navigationActions: navigationActions,
      utilityActions: utilityActions,
    );

    return SliverAppBar(
      pinned: true,
      forceElevated: true,
      expandedHeight: expandedHeight,
      backgroundColor: Colors.black87,
      actions: actions,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final motion = HeaderMotion.resolve(
            responsive: responsive,
            topPadding: topPadding,
            expandedHeight: expandedHeight,
            currentHeight: constraints.maxHeight,
            hasTitle: title != null,
            titleAspectRatio: title != null
                ? title!.height / title!.width
                : 1.0,
            hasSubtitle: subtitle != null,
            subtitleAspectRatio: subtitle != null
                ? subtitle!.height / subtitle!.width
                : 1.0,
          );

          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: ClipRect(
                  child: Transform.scale(
                    scale: backgroundStyle.scale,
                    alignment: backgroundStyle.alignment,
                    child: background.image,
                  ),
                ),
              ),
              if (navLogo != null)
                Positioned(
                  left: motion.iconLeft,
                  top: motion.iconTop,
                  child: IgnorePointer(
                    child: SizedBox.square(
                      dimension: motion.iconSize,
                      child: FittedBox(fit: BoxFit.contain, child: navLogo!),
                    ),
                  ),
                ),
              if (title != null)
                Positioned(
                  left: motion.titleLeft,
                  top: motion.titleTop,
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: motion.titleOpacity,
                      child: SizedBox(
                        width: motion.titleWidth,
                        height: motion.titleHeight,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                          child: title!.image,
                        ),
                      ),
                    ),
                  ),
                ),
              if (motion.shouldShowSubtitle)
                Positioned(
                  left: motion.subtitleLeft,
                  top: motion.subtitleTop,
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: motion.subtitleOpacity,
                      child: SizedBox(
                        width: motion.subtitleWidth,
                        height: motion.subtitleHeight,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Color(0xCCFFFFFF),
                            BlendMode.srcIn,
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            child: subtitle!.image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
