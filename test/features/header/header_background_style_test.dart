import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/features/header/header_background_style.dart';
import 'package:my_portfolio/shared/parts/breakpoint.dart';

void main() {
  group('HeaderBackgroundStyle.resolve', () {
    test('returns a tighter crop for xs', () {
      final style = HeaderBackgroundStyle.resolve(
        BreakpointSize(const Size(375, 812), Breakpoint.xs),
      );

      expect(style.scale, 1.28);
      expect(style.alignment, const Alignment(0.24, -0.12));
    });

    test('returns a moderate crop for sm', () {
      final style = HeaderBackgroundStyle.resolve(
        BreakpointSize(const Size(768, 1024), Breakpoint.sm),
      );

      expect(style.scale, 1.12);
      expect(style.alignment, const Alignment(0.14, -0.08));
    });

    test('keeps the original composition from md and above', () {
      final style = HeaderBackgroundStyle.resolve(
        BreakpointSize(const Size(1024, 768), Breakpoint.md),
      );

      expect(style.scale, 1.0);
      expect(style.alignment, Alignment.center);
    });
  });
}
