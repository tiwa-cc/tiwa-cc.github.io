import 'package:flutter/material.dart';
import 'package:my_portfolio/shared/themes/app_theme_extensions.dart';

/// A class that holds the theme data for the application.
final class AppThemeData {
  /// The theme data for the application.
  static ThemeData themeData = ThemeData(
    /// Sets the AppBarTheme.
    appBarTheme: AppBarTheme(
      toolbarHeight: 80.0,
      elevation: 0.0,
      // 文字色指定
      foregroundColor: Color.fromRGBO(0xff, 0xc8, 0x00, 0.0),
      backgroundColor: Color.fromRGBO(0x6c, 0x75, 0x7d, 0.0),
      // アイコン
      // leadingWidth: 180.0,
      // タイトル
      // centerTitle: true,
      titleSpacing: 80.0,
      // メニュー
      actionsPadding: EdgeInsets.fromLTRB(0.0, 0.0, 32.0, 0.0),
    ),
    fontFamily: 'Roboto',
    extensions: AppThemeExtensions.extensions,
  );
}
