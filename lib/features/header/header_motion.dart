import 'dart:ui' show clampDouble, lerpDouble;

import 'package:flutter/material.dart';
import 'package:my_portfolio/shared/parts/breakpoint.dart';

final class HeaderMotion {
  final double iconLeft;
  final double iconTop;
  final double iconSize;
  final double titleLeft;
  final double titleTop;
  final double titleWidth;
  final double titleHeight;
  final double titleOpacity;
  final bool showSubtitle;
  final double subtitleLeft;
  final double subtitleTop;
  final double subtitleWidth;
  final double subtitleHeight;
  final double subtitleOpacity;

  const HeaderMotion({
    required this.iconLeft,
    required this.iconTop,
    required this.iconSize,
    required this.titleLeft,
    required this.titleTop,
    required this.titleWidth,
    required this.titleHeight,
    required this.titleOpacity,
    required this.showSubtitle,
    required this.subtitleLeft,
    required this.subtitleTop,
    required this.subtitleWidth,
    required this.subtitleHeight,
    required this.subtitleOpacity,
  });

  bool get shouldShowSubtitle =>
      showSubtitle && subtitleWidth > 0 && subtitleHeight > 0;

  factory HeaderMotion.resolve({
    required BreakpointSize responsive,
    required double topPadding,
    required double expandedHeight,
    required double currentHeight,
    required bool hasTitle,
    required double titleAspectRatio,
    required bool hasSubtitle,
    required double subtitleAspectRatio,
  }) {
    final safeWidth = responsive.size.width > 0 ? responsive.size.width : 375.0;
    final collapsedHeight = kToolbarHeight + topPadding;
    final availableHeight = expandedHeight > collapsedHeight
        ? expandedHeight - collapsedHeight
        : 1.0;
    final expandedRatio = clampDouble(
      (currentHeight - collapsedHeight) / availableHeight,
      0,
      1,
    );
    final collapseRatio = Curves.easeInOutCubic.transform(1 - expandedRatio);
    final horizontalPadding = switch (responsive.breakpoint) {
      Breakpoint.xs => 12.0,
      Breakpoint.sm => 16.0,
      _ => 24.0,
    };
    final iconExpandedSize = switch (responsive.breakpoint) {
      Breakpoint.xs => clampDouble(safeWidth * 0.18, 72, 88),
      Breakpoint.sm => clampDouble(safeWidth * 0.14, 88, 104),
      Breakpoint.md => 112.0,
      Breakpoint.lg => 124.0,
      Breakpoint.xl => 132.0,
    };
    final iconCollapsedSize = responsive.isXs ? 28.0 : 32.0;
    final iconGap = responsive.isXs ? 12.0 : 18.0;
    final titleExpandedWidth = hasTitle
        ? clampDouble(
            safeWidth *
                switch (responsive.breakpoint) {
                  Breakpoint.xs => 0.58,
                  Breakpoint.sm => 0.54,
                  Breakpoint.md => 0.5,
                  Breakpoint.lg => 0.46,
                  Breakpoint.xl => 0.42,
                },
            160,
            clampDouble(
              safeWidth - horizontalPadding * 2 - iconExpandedSize - iconGap,
              160,
              860,
            ),
          )
        : 0.0;
    final titleCollapsedWidth = titleExpandedWidth * 0.72;
    final showSubtitle = hasTitle && hasSubtitle && !responsive.isXs;
    final heroGroupWidth =
        iconExpandedSize + (hasTitle ? iconGap + titleExpandedWidth : 0.0);
    final maxExpandedIconLeft =
        safeWidth - horizontalPadding - iconExpandedSize;
    final expandedIconLeft = maxExpandedIconLeft <= horizontalPadding
        ? horizontalPadding
        : clampDouble(
            (safeWidth - heroGroupWidth) / 2 + safeWidth * 0.05,
            horizontalPadding,
            maxExpandedIconLeft,
          );
    final collapsedIconLeft = horizontalPadding;
    final contentCenterY = topPadding + (currentHeight - topPadding) / 2;
    final iconLeft = lerpDouble(
      expandedIconLeft,
      collapsedIconLeft,
      collapseRatio,
    )!;
    final iconSize = lerpDouble(
      iconExpandedSize,
      iconCollapsedSize,
      collapseRatio,
    )!;
    final iconTop = contentCenterY - iconSize / 2;
    final expandedTitleLeft = expandedIconLeft + iconExpandedSize + iconGap;
    final collapsedTitleLeft = collapsedIconLeft + iconCollapsedSize + 12;
    final titleLeft = hasTitle
        ? lerpDouble(expandedTitleLeft, collapsedTitleLeft, collapseRatio)!
        : 0.0;
    final titleWidth = hasTitle
        ? lerpDouble(titleExpandedWidth, titleCollapsedWidth, collapseRatio)!
        : 0.0;
    final titleHeight = titleWidth * titleAspectRatio;
    final subtitleBaseWidth = showSubtitle
        ? titleWidth * (responsive.isSm ? 0.7 : 0.78)
        : 0.0;
    final subtitleBaseHeight = subtitleBaseWidth * subtitleAspectRatio;
    final subtitleFadeProgress = clampDouble(collapseRatio / 0.3, 0, 1);
    final subtitleOpacity = 1 - Curves.easeOut.transform(subtitleFadeProgress);
    final subtitleScale =
        (1 - subtitleFadeProgress) *
        lerpDouble(1.0, 0.9, Curves.easeOut.transform(subtitleFadeProgress))!;
    final subtitleWidth = subtitleBaseWidth * subtitleScale;
    final subtitleHeight = subtitleBaseHeight * subtitleScale;
    final subtitleGap =
        (showSubtitle ? (responsive.isSm ? 8.0 : 12.0) : 0.0) *
        (1 - subtitleFadeProgress);
    final textBlockHeight =
        titleHeight + (showSubtitle ? subtitleGap + subtitleHeight : 0.0);
    final titleTop = hasTitle ? contentCenterY - textBlockHeight / 2 : 0.0;
    final titleOpacity = hasTitle
        ? 1 -
              Curves.easeOut.transform(
                clampDouble((collapseRatio - 0.7) / 0.3, 0, 1),
              )
        : 0.0;
    final subtitleTop = titleTop + titleHeight + subtitleGap;
    final subtitleLeft = titleLeft + (titleWidth - subtitleWidth) / 2;

    return HeaderMotion(
      iconLeft: iconLeft,
      iconTop: iconTop,
      iconSize: iconSize,
      titleLeft: titleLeft,
      titleTop: titleTop,
      titleWidth: titleWidth,
      titleHeight: titleHeight,
      titleOpacity: titleOpacity,
      showSubtitle: showSubtitle,
      subtitleLeft: subtitleLeft,
      subtitleTop: subtitleTop,
      subtitleWidth: subtitleWidth,
      subtitleHeight: subtitleHeight,
      subtitleOpacity: subtitleOpacity,
    );
  }
}
