import 'package:flutter/material.dart';

class PortfolioPanel extends StatelessWidget {
  const PortfolioPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(20, (index) => const Text('PortfolioPanel')),
    );
  }
}
