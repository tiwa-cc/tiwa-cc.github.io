import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_extensions_gen_annotations/theme_extensions_gen_annotations.dart';

part 'copyright_theme.g.dart';

@ThemeExtensionTemplate()
abstract interface class CopyrightTheme extends ThemeExtension<CopyrightTheme>
    with _$CopyrightThemeMixin, Diagnosticable {
  const factory CopyrightTheme({required TextStyle style}) = _$CopyrightTheme;
}

extension CopyrightThemeExt on CopyrightTheme {
  static CopyrightTheme? theme(BuildContext context) {
    return Theme.of(context).extension<CopyrightTheme>();
  }
}
