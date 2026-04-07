import 'package:flutter/material.dart';

final class HeaderPopupMenuTheme extends ThemeExtension<HeaderPopupMenuTheme> {
  const HeaderPopupMenuTheme({
    required this.menuIconData,
    required this.menuIconColor,
    required this.menuBackgroundColor,
  });

  final IconData menuIconData;
  final Color menuIconColor;
  final Color menuBackgroundColor;

  static const HeaderPopupMenuTheme fallback = HeaderPopupMenuTheme(
    menuIconData: Icons.menu,
    menuIconColor: Colors.white,
    menuBackgroundColor: Colors.black87,
  );

  static HeaderPopupMenuTheme theme(BuildContext context) =>
      Theme.of(context).extension<HeaderPopupMenuTheme>() ?? fallback;

  @override
  HeaderPopupMenuTheme copyWith({
    IconData? menuIconData,
    Color? menuIconColor,
    Color? menuBackgroundColor,
  }) {
    return HeaderPopupMenuTheme(
      menuIconData: menuIconData ?? this.menuIconData,
      menuIconColor: menuIconColor ?? this.menuIconColor,
      menuBackgroundColor: menuBackgroundColor ?? this.menuBackgroundColor,
    );
  }

  @override
  HeaderPopupMenuTheme lerp(
    covariant ThemeExtension<HeaderPopupMenuTheme>? other,
    double t,
  ) {
    if (other is! HeaderPopupMenuTheme) {
      return this;
    }

    return HeaderPopupMenuTheme(
      menuIconData: t < 0.5 ? menuIconData : other.menuIconData,
      menuIconColor:
          Color.lerp(menuIconColor, other.menuIconColor, t) ?? menuIconColor,
      menuBackgroundColor:
          Color.lerp(menuBackgroundColor, other.menuBackgroundColor, t) ??
          menuBackgroundColor,
    );
  }
}
