import 'package:flutter/material.dart';

final class CopyrightTheme extends ThemeExtension<CopyrightTheme> {
  const CopyrightTheme({required this.style});

  final TextStyle style;

  static const TextStyle fallbackStyle = TextStyle(
    color: Colors.grey,
    fontSize: 12,
  );

  static const CopyrightTheme fallback = CopyrightTheme(style: fallbackStyle);

  static CopyrightTheme theme(BuildContext context) =>
      Theme.of(context).extension<CopyrightTheme>() ?? fallback;

  @override
  CopyrightTheme copyWith({TextStyle? style}) {
    return CopyrightTheme(style: style ?? this.style);
  }

  @override
  CopyrightTheme lerp(
    covariant ThemeExtension<CopyrightTheme>? other,
    double t,
  ) {
    if (other is! CopyrightTheme) {
      return this;
    }

    return CopyrightTheme(
      style: TextStyle.lerp(style, other.style, t) ?? style,
    );
  }
}
