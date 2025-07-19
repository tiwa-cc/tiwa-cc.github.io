import 'package:flutter/material.dart';
import 'package:my_portfolio/shared/parts/breakpoint.dart';

class AppResponsive<T> extends StatelessWidget {
  final Map<Breakpoint, T?> _map;
  final Widget Function(BuildContext context, T? value) builder;

  AppResponsive({
    super.key,
    required this.builder,
    T? xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) : _map = {
         Breakpoint.xs: xs,
         Breakpoint.sm: sm ?? xs,
         Breakpoint.md: md ?? sm ?? xs,
         Breakpoint.lg: lg ?? md ?? sm ?? xs,
         Breakpoint.xl: xl ?? lg ?? md ?? sm ?? xs,
       };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final bp = Breakpoint.values.where((bp) => bp.inRange(width)).first;
        final value = _map[bp];
        return builder(context, value);
      },
    );
  }
}
