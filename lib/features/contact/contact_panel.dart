import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/l10n/l10n.dart';

class ContactPanel extends StatelessWidget {
  final VoidCallback onHeader;

  const ContactPanel({super.key, required this.onHeader});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final title = l10n.contactTitle;
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
        Row(
          children: [
            IconButton(onPressed: null, icon: Icon(FontAwesomeIcons.xTwitter)),
            IconButton(onPressed: null, icon: Icon(FontAwesomeIcons.facebook)),
            IconButton(onPressed: null, icon: Icon(FontAwesomeIcons.linkedin)),
          ],
        ),
      ],
    );
  }
}
