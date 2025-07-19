import 'package:flutter/material.dart';
import 'package:my_portfolio/res/asset_navbar_logo.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return AssetNavbarLogo().image;
  }
}
