import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_extensions_gen_annotations/theme_extensions_gen_annotations.dart';

part 'brand_name_theme.g.dart';

@ThemeExtensionTemplate()
abstract interface class BrandNameTheme extends ThemeExtension<BrandNameTheme>
    with _$BrandNameThemeMixin, Diagnosticable {
  const factory BrandNameTheme({required TextStyle style}) = _$BrandNameTheme;
}

extension BrandNameThemeExt on BrandNameTheme {
  static BrandNameTheme? theme(BuildContext context) {
    return Theme.of(context).extension<BrandNameTheme>();
  }
}
