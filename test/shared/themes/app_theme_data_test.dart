import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/shared/themes/app_theme_data.dart';
import 'package:my_portfolio/shared/themes/author_name_theme.dart';
import 'package:my_portfolio/shared/themes/copyright_theme.dart';
import 'package:my_portfolio/shared/themes/header_popup_menu_theme.dart';
import 'package:my_portfolio/shared/themes/header_view_button_theme.dart';
import 'package:my_portfolio/shared/themes/info_card_theme.dart';

void main() {
  test('registers the custom theme extensions used by the app', () {
    final theme = AppThemeData.themeData;

    expect(theme.extension<AuthorNameTheme>(), isNotNull);
    expect(theme.extension<HeaderViewButtonTheme>(), isNotNull);
    expect(theme.extension<InfoCardTheme>(), isNotNull);
    expect(theme.extension<CopyrightTheme>(), isNotNull);
    expect(theme.extension<HeaderPopupMenuTheme>(), isNotNull);
  });
}
