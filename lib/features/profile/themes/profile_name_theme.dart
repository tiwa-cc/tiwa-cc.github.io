import 'package:flutter/cupertino.dart';
import 'package:my_portfolio/shared/themes/author_name_theme.dart';

final class ProfileNameTheme {
  static AuthorNameTheme get theme => AuthorNameTheme(
    style: TextStyle(
      fontSize: 24,
      letterSpacing: 2.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
    ),
  );
}
