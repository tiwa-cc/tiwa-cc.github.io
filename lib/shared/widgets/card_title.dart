import 'package:flutter/material.dart';

final class CardTitle extends StatelessWidget {
  const CardTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(text: title),
      textScaler: TextScaler.linear(1.5),
    );
  }
}
