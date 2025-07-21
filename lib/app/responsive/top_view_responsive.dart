import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/app/responsive/top_view_holder.dart';
import 'package:my_portfolio/app/responsive/top_view_sm.dart';
import 'package:my_portfolio/app/responsive/top_view_xs.dart';
import 'package:my_portfolio/shared/providers.dart';

class TopViewResponsive extends ConsumerWidget {
  const TopViewResponsive({super.key, required this.holder});

  final TopViewHolder holder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(breakpointSizeProvider);

    if (responsive.isXs) {
      return TopViewXs(holder: holder);
    }
    return TopViewSm(holder: holder);
  }
}
