import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/shared/providers.dart';

final class LayoutWidthFrame extends ConsumerWidget {
  const LayoutWidthFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preset = ref.watch(layoutWidthPresetProvider);
    final forcedWidth = preset.width;
    if (forcedWidth == null) {
      return child;
    }

    final mediaQuery = MediaQuery.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveWidth = math.min(forcedWidth, constraints.maxWidth);
        final frame = MediaQuery(
          data: mediaQuery.copyWith(
            size: Size(effectiveWidth, mediaQuery.size.height),
          ),
          child: child,
        );

        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: effectiveWidth,
            height: constraints.hasBoundedHeight ? constraints.maxHeight : null,
            child: frame,
          ),
        );
      },
    );
  }
}
