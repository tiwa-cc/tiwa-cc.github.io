import 'package:flutter/material.dart';

final class AuthorNameTheme extends ThemeExtension<AuthorNameTheme> {
  const AuthorNameTheme({required this.style});

  final TextStyle style;

  static const TextStyle fallbackStyle = TextStyle(
    fontSize: 24,
    letterSpacing: 2.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.underline,
  );

  static const AuthorNameTheme fallback = AuthorNameTheme(style: fallbackStyle);

  static AuthorNameTheme theme(BuildContext context) =>
      Theme.of(context).extension<AuthorNameTheme>() ?? fallback;

  @override
  AuthorNameTheme copyWith({TextStyle? style}) {
    return AuthorNameTheme(style: style ?? this.style);
  }

  @override
  AuthorNameTheme lerp(
    covariant ThemeExtension<AuthorNameTheme>? other,
    double t,
  ) {
    if (other is! AuthorNameTheme) {
      return this;
    }

    return AuthorNameTheme(
      style: TextStyle.lerp(style, other.style, t) ?? style,
    );
  }
}
