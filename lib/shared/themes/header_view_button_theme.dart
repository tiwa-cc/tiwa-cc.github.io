import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_extensions_gen_annotations/theme_extensions_gen_annotations.dart';

part 'header_view_button_theme.g.dart';

@ThemeExtensionTemplate()
abstract interface class HeaderViewButtonTheme
    extends ThemeExtension<HeaderViewButtonTheme>
    with _$HeaderViewButtonThemeMixin, Diagnosticable {
  const factory HeaderViewButtonTheme({required ButtonStyle style}) =
      _$HeaderViewButtonTheme;
}

extension HeaderViewButtonThemeExt on HeaderViewButtonTheme {
  static HeaderViewButtonTheme? theme(BuildContext context) {
    return Theme.of(context).extension<HeaderViewButtonTheme>();
  }
}
