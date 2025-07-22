import 'package:flutter/material.dart';
import 'package:my_portfolio/shared/themes/brand_name_theme.dart';

final class FooterBrandNameTheme {
  static BrandNameTheme theme(BuildContext context) => const BrandNameTheme(
    style: TextStyle(
      color: Colors.white,
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
    ),
  );
}
