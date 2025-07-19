enum AppScreenSize {
  xs, // 0 < 600
  sm, // 600 - 904
  md, // 905 - 1239
  lg, // 1240 - 1439
  xl, // 1440+
}

extension AppScreenSizeExt on AppScreenSize {
  int get min => switch (this) {
    AppScreenSize.xs => 0,
    AppScreenSize.sm => 600,
    AppScreenSize.md => 905,
    AppScreenSize.lg => 1240,
    AppScreenSize.xl => 1440,
  };

  int get max => switch (this) {
    AppScreenSize.xs => 599,
    AppScreenSize.sm => 904,
    AppScreenSize.md => 1239,
    AppScreenSize.lg => 1439,
    AppScreenSize.xl => 65535,
  };

  bool get isMobile => this == AppScreenSize.xs || this == AppScreenSize.sm;
  bool get isTablet => this == AppScreenSize.md;
  bool get isDesktop => this == AppScreenSize.lg || this == AppScreenSize.xl;
}
