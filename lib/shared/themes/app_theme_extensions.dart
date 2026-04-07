import 'package:flutter/material.dart';
import 'package:my_portfolio/shared/themes/author_name_theme.dart';
import 'package:my_portfolio/shared/themes/copyright_theme.dart';
import 'package:my_portfolio/shared/themes/header_popup_menu_theme.dart';
import 'package:my_portfolio/shared/themes/header_view_button_theme.dart';
import 'package:my_portfolio/shared/themes/info_card_theme.dart';

/// A class that holds the theme data for the application.
final class AppThemeExtensions {
  /// The list of theme extensions for the application.
  static List<ThemeExtension<dynamic>> resolve(ThemeData theme) =>
      <ThemeExtension<dynamic>>[
        AuthorNameTheme.fallback,
        HeaderViewButtonTheme.fallback,
        CopyrightTheme.fallback,
        HeaderPopupMenuTheme.fallback,
        InfoCardTheme.fallback(theme),
      ];
}
