import 'package:flutter/material.dart';
import 'package:my_portfolio/shared/themes/copyright_theme.dart';

final class FooterCopyrightTheme {
  static CopyrightTheme theme(BuildContext context) => CopyrightTheme(
    style: const TextStyle(color: Colors.grey, fontSize: 12.0),
  );
}
