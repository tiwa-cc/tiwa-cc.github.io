import 'package:flutter/material.dart';
import 'package:my_portfolio/res/interfaces/image_interface.dart';

class HeaderView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final expandedHeight = background.screenHeight(mediaQuery.size.width);

    return SliverAppBar(
      pinned: true,
      forceElevated: true,
      expandedHeight: expandedHeight,
      title: navLogo,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          alignment: Alignment.center,
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
