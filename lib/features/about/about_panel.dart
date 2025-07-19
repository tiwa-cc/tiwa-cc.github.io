import 'package:flutter/material.dart';

class AboutPanel extends StatelessWidget {
  final VoidCallback onHeader;

  const AboutPanel({super.key, required this.onHeader});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topRight,
          child: ElevatedButton(onPressed: onHeader, child: Text('▲')),
        ),
        RichText(
          text: const TextSpan(text: 'ABOUT'),
          textScaler: TextScaler.linear(4.0),
        ),
        ...List.generate(20, (index) => const Text('AboutPanel')),
      ],
    );
  }
}
