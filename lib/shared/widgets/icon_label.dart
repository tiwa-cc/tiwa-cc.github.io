import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconLabel extends StatelessWidget {
  const IconLabel({
    super.key,
    required this.icon,
    required this.title,
    this.semanticLabel,
    this.size,
    this.fontSize,
  });

  final IconData icon;
  final String title;
  final String? semanticLabel;
  final double? size;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(icon, semanticLabel: semanticLabel, size: size ?? 16.0),
        SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize ?? 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
