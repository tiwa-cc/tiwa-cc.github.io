import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A notifier that tracks the current breakpoint size based on the screen width.
class BreakpointSizeNotifier extends StateNotifier<BreakpointSize> {
  BreakpointSizeNotifier() : super(BreakpointSize(Size.zero, Breakpoint.xs));

  void update(Size size) {
    state = BreakpointSize(
      size,
      Breakpoint.values.firstWhere(
        (breakpoint) => breakpoint.inRange(size.width),
      ),
    );
  }
}

/// Represents a size and its corresponding breakpoint.
class BreakpointSize {
  /// Creates a BreakpointSize with the given size and breakpoint.
  final Size size;

  /// The breakpoint that corresponds to the size.
  final Breakpoint breakpoint;

  /// Constructs a BreakpointSize with the specified size and breakpoint.
  BreakpointSize(this.size, this.breakpoint);

  bool get isXs => breakpoint == Breakpoint.xs;
  bool get isSm => breakpoint == Breakpoint.sm;
  bool get isMd => breakpoint == Breakpoint.md;
  bool get isLg => breakpoint == Breakpoint.lg;
  bool get isXl => breakpoint == Breakpoint.xl;
}

/// An enum representing different breakpoints for responsive design.
enum Breakpoint {
  /// Extra small devices (phones, 0 - 600px).
  xs,

  /// Small devices (tablets, 600 - 905px).
  sm,

  /// Medium devices (small laptops, 905 - 1240px).
  md,

  /// Large devices (desktops, 1240 - 1440px).
  lg,

  /// Extra large devices (large desktops, 1440px and above).
  xl,
}

/// Extension methods for Breakpoint to provide min and max width values.
extension BreakpointExt on Breakpoint {
  /// Returns the minimum width for the breakpoint.
  double min() {
    return switch (this) {
      Breakpoint.xs => 0,
      Breakpoint.sm => 600,
      Breakpoint.md => 905,
      Breakpoint.lg => 1240,
      Breakpoint.xl => 1440,
    };
  }

  /// Returns the maximum width for the breakpoint.
  double max() {
    return switch (this) {
      Breakpoint.xs => 600,
      Breakpoint.sm => 905,
      Breakpoint.md => 1240,
      Breakpoint.lg => 1440,
      Breakpoint.xl => 65535,
    };
  }

  /// Checks if a given width falls within the range of the breakpoint.
  bool inRange(double width) {
    return min() <= width && width < max();
  }
}
