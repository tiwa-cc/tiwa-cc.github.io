import 'package:flutter/material.dart';

final class PortfolioViewButton extends StatelessWidget {
  const PortfolioViewButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text('PORTFOLIO'));
  }
}
