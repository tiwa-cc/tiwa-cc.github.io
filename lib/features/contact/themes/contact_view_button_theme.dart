import 'package:flutter/material.dart';
import 'package:my_portfolio/shared/themes/header_view_button_theme.dart';

final class ContactViewButtonTheme {
  static HeaderViewButtonTheme? theme(BuildContext context) {
    return HeaderViewButtonTheme(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.fromMap({
          WidgetState.any: Colors.yellow,
        }),
        shadowColor: WidgetStateProperty.fromMap({
          WidgetState.any: Colors.blueGrey,
        }),
      ),
    );
  }
}
