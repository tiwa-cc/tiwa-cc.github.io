import 'package:flutter/material.dart';
import 'package:my_portfolio/l10n/l10n.dart';

final class PortfolioViewButton extends StatelessWidget {
  const PortfolioViewButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final title = l10n.portfolioTitle;
    return TextButton(onPressed: onPressed, child: Text(title));
  }
}
