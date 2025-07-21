import 'package:flutter/material.dart';

/// A class that holds the theme data for the application.
final class AppThemeExtensions {
  /// The list of theme extensions for the application.
  static List<ThemeExtension<dynamic>> extensions = [
    /// AppBarTitleStyle
    AppBarTitleStyle(),
  ];
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
