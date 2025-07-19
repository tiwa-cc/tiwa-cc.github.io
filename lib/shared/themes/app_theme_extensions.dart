import 'package:flutter/material.dart';

final class AppThemeExtensions {
  static List<ThemeExtension<dynamic>> extensions = [AppBarTitleStyle()];
}

final class AppBarTitleStyle extends ThemeExtension<AppBarTitleStyle> {
  @override
  ThemeExtension<AppBarTitleStyle> copyWith() => AppBarTitleStyle();

  @override
  ThemeExtension<AppBarTitleStyle> lerp(
    covariant ThemeExtension<AppBarTitleStyle>? other,
    double t,
  ) {
    if (other is! AppBarTitleStyle) {
      return this;
    }

    return AppBarTitleStyle();
  }
}
