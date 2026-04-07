import 'package:flutter/material.dart';

final class CardSubtitle extends StatelessWidget {
  const CardSubtitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        // fontStyle: FontStyle.italic,
        // color: Colors.grey,
        decoration: TextDecoration.underline,
      ),
      textScaler: TextScaler.linear(1.2),
    );
  }
}
