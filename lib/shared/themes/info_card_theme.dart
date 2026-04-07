import 'package:flutter/material.dart';

final class InfoCardTheme extends ThemeExtension<InfoCardTheme> {
  const InfoCardTheme({
    required this.titleStyle,
    required this.subtitleStyle,
    required this.durationStyle,
  });

  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final TextStyle durationStyle;

  static InfoCardTheme fallback(ThemeData theme) => InfoCardTheme(
    titleStyle:
        theme.textTheme.titleMedium ??
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    subtitleStyle: (theme.textTheme.bodyMedium ?? const TextStyle()).copyWith(
      fontStyle: FontStyle.italic,
    ),
    durationStyle: (theme.textTheme.bodySmall ?? const TextStyle(fontSize: 12))
        .copyWith(color: const Color(0xFF757575)),
  );

  static InfoCardTheme theme(BuildContext context) {
    final materialTheme = Theme.of(context);
    return materialTheme.extension<InfoCardTheme>() ?? fallback(materialTheme);
  }

  @override
  InfoCardTheme copyWith({
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? durationStyle,
  }) {
    return InfoCardTheme(
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      durationStyle: durationStyle ?? this.durationStyle,
    );
  }

  @override
  InfoCardTheme lerp(covariant ThemeExtension<InfoCardTheme>? other, double t) {
    if (other is! InfoCardTheme) {
      return this;
    }

    return InfoCardTheme(
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t) ?? titleStyle,
      subtitleStyle:
          TextStyle.lerp(subtitleStyle, other.subtitleStyle, t) ??
          subtitleStyle,
      durationStyle:
          TextStyle.lerp(durationStyle, other.durationStyle, t) ??
          durationStyle,
    );
  }
}
