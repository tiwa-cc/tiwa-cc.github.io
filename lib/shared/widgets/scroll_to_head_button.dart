import 'package:flutter/material.dart';

final class ScrollToHeadButton extends StatelessWidget {
  const ScrollToHeadButton({super.key, required this.onHeader});

  final VoidCallback onHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topRight,
      child: ElevatedButton(onPressed: onHeader, child: Text('▲')),
    );
  }
}
