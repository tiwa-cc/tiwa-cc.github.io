import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/res/interfaces/image_interface.dart';
import 'package:my_portfolio/shared/parts/breakpoint.dart';
import 'package:my_portfolio/shared/providers.dart';

class HeaderView extends ConsumerWidget {
  final ImageInterface background;
  final Widget navLogo;
  final List<Widget> actions;
  final ImageInterface title;
  final ImageInterface subtitle;

  const HeaderView({
    super.key,
    required this.background,
    required this.navLogo,
    required this.actions,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(breakpointSizeProvider);
    final expandedHeight = background.screenHeight(responsive.size.width);

    return SliverAppBar(
      pinned: true,
      forceElevated: true,
      expandedHeight: expandedHeight,
      title: navLogo,
      backgroundColor: Colors.black87,
      actions: switch (responsive.breakpoint) {
        Breakpoint.xl => null,
        Breakpoint.lg => null,
        Breakpoint.md => null,
        Breakpoint.sm => actions,
        Breakpoint.xs => actions,
      },
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            background.image,
            Padding(
              padding: EdgeInsets.only(top: expandedHeight * 0.4),
              child: Column(children: [subtitle.image, title.image]),
            ),
          ],
        ),
      ),
    );
  }
}
