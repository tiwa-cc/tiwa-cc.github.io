import 'package:flutter/material.dart';
import 'package:my_portfolio/shared/parts/breakpoint.dart';

/// Breakpoint-aware presentation for the header background photo.
final class HeaderBackgroundStyle {
  final double scale;
  final Alignment alignment;

  const HeaderBackgroundStyle({required this.scale, required this.alignment});

  factory HeaderBackgroundStyle.resolve(BreakpointSize responsive) {
    return switch (responsive.breakpoint) {
      // Narrow screens benefit from a tighter crop so the subject does not
      // feel too distant inside the short hero area.
      Breakpoint.xs => const HeaderBackgroundStyle(
        scale: 1.28,
        alignment: Alignment(0.24, -0.12),
      ),
      Breakpoint.sm => const HeaderBackgroundStyle(
        scale: 1.12,
        alignment: Alignment(0.14, -0.08),
      ),
      _ => const HeaderBackgroundStyle(scale: 1.0, alignment: Alignment.center),
    };
  }
}
