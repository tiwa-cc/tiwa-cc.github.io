import 'package:flutter/material.dart';

final class HeaderViewButtonTheme
    extends ThemeExtension<HeaderViewButtonTheme> {
  const HeaderViewButtonTheme({required this.style});

  final ButtonStyle style;

  static const ButtonStyle fallbackStyle = ButtonStyle(
    foregroundColor: WidgetStatePropertyAll<Color>(Colors.yellow),
    shadowColor: WidgetStatePropertyAll<Color>(Colors.blueGrey),
  );

  static const HeaderViewButtonTheme fallback = HeaderViewButtonTheme(
    style: fallbackStyle,
  );

  static HeaderViewButtonTheme theme(BuildContext context) =>
      Theme.of(context).extension<HeaderViewButtonTheme>() ?? fallback;

  @override
  HeaderViewButtonTheme copyWith({ButtonStyle? style}) {
    return HeaderViewButtonTheme(style: style ?? this.style);
  }

  @override
  HeaderViewButtonTheme lerp(
    covariant ThemeExtension<HeaderViewButtonTheme>? other,
    double t,
  ) {
    if (other is! HeaderViewButtonTheme) {
      return this;
    }

    return HeaderViewButtonTheme(
      style:
          ButtonStyle.lerp(style, other.style, t) ??
          (t < 0.5 ? style : other.style),
    );
  }
}
