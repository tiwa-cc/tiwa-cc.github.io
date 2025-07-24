import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_extensions_gen_annotations/theme_extensions_gen_annotations.dart';

part 'author_name_theme.g.dart';

@ThemeExtensionTemplate()
abstract interface class AuthorNameTheme extends ThemeExtension<AuthorNameTheme>
    with _$AuthorNameThemeMixin, Diagnosticable {
  const factory AuthorNameTheme({required TextStyle style}) = _$AuthorNameTheme;
}

extension AuthorNameThemeExt on AuthorNameTheme {
  static AuthorNameTheme? theme(BuildContext context) {
    return Theme.of(context).extension<AuthorNameTheme>();
  }
}
