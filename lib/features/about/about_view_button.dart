import 'package:flutter/material.dart';
import 'package:my_portfolio/features/about/themes/about_view_button_style.dart';
import 'package:my_portfolio/l10n/l10n.dart';

final class AboutViewButton extends StatelessWidget {
  const AboutViewButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final style = AboutViewButtonStyle();
    return TextButton(
      style: style,
      onPressed: onPressed,
      child: Text(l10n.aboutTitle),
    );
  }
}
