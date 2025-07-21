import 'package:flutter/material.dart';
import 'package:my_portfolio/l10n/l10n.dart';

class ProfilePanel extends StatelessWidget {
  final VoidCallback onHeader;

  const ProfilePanel({super.key, required this.onHeader});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final title = l10n.profileTitle;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topRight,
          child: ElevatedButton(onPressed: onHeader, child: Text('▲')),
        ),
        RichText(
          text: TextSpan(text: title),
          textScaler: TextScaler.linear(4.0),
        ),
        ...List.generate(20, (index) => Text("${title}Panel")),
      ],
    );
  }
}
