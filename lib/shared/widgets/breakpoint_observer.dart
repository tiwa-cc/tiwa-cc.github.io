import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/shared/providers.dart';

/// A widget that observes the current breakpoint size and updates the state.
final class BreakpointObserver extends ConsumerWidget {
  const BreakpointObserver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final state = ref.watch(breakpointSizeProvider);
    if (state.size != mediaQuery.size) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final notifier = ref.read(breakpointSizeProvider.notifier);
        notifier.update(mediaQuery.size);
      });
    }
    return SizedBox.shrink();
  }
}
