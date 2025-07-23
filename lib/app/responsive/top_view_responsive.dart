import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/app/responsive/top_view_holder.dart';
import 'package:my_portfolio/app/responsive/top_view_lg.dart';
import 'package:my_portfolio/app/responsive/top_view_md.dart';
import 'package:my_portfolio/app/responsive/top_view_sm.dart';
import 'package:my_portfolio/app/responsive/top_view_xl.dart';
import 'package:my_portfolio/app/responsive/top_view_xs.dart';
import 'package:my_portfolio/shared/parts/breakpoint.dart';
import 'package:my_portfolio/shared/providers.dart';

class TopViewResponsive extends ConsumerWidget {
  const TopViewResponsive({super.key, required this.holder});

  final TopViewHolder holder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(breakpointSizeProvider);
    return switch (responsive.breakpoint) {
      Breakpoint.xl => TopViewXl(holder: holder),
      Breakpoint.lg => TopViewLg(holder: holder),
      Breakpoint.md => TopViewMd(holder: holder),
      Breakpoint.sm => TopViewSm(holder: holder),
      Breakpoint.xs => TopViewXs(holder: holder),
    };
  }
}
