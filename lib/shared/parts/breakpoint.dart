enum Breakpoint { xs, sm, md, lg, xl }

extension BreakpointExt on Breakpoint {
  double min() {
    return switch (this) {
      Breakpoint.xs => 0,
      Breakpoint.sm => 600,
      Breakpoint.md => 905,
      Breakpoint.lg => 1240,
      Breakpoint.xl => 1440,
    };
  }

  double max() {
    return switch (this) {
      Breakpoint.xs => 600,
      Breakpoint.sm => 905,
      Breakpoint.md => 1240,
      Breakpoint.lg => 1440,
      Breakpoint.xl => 65535,
    };
  }

  bool inRange(double width) {
    return min() <= width && width < max();
  }
}
