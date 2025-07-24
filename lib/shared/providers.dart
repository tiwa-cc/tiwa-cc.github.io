import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/shared/parts/breakpoint.dart';

/// A provider that holds the current breakpoint size.
final breakpointSizeProvider = StateNotifierProvider(
  (ref) => BreakpointSizeNotifier(),
);

/// A notifier that manages the current breakpoint size.
final topViewScrollPositionProvider = StateProvider<double>((ref) {
  return 0.0; // Default scroll position
});
