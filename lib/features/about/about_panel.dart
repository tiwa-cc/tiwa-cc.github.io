import 'package:flutter/material.dart';
import 'package:my_portfolio/l10n/l10n.dart';

class AboutPanel extends StatelessWidget {
  final VoidCallback onHeader;

  const AboutPanel({super.key, required this.onHeader});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ScrollToHeadButton(onHeader: onHeader),
        // CardTitle(title: title),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'ITフリーランスエンジニアの'),
              TextSpan(
                text: l10n.author,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: 'です。\n'),
              TextSpan(text: '携帯電話のアプリ開発や、Webサイトの制作を行っています。\n'),
              TextSpan(text: 'なんたらかんたら。うんたらかんたら。\n'),
              TextSpan(text: 'なんたらかんたら。うんたらかんたら。\n'),
              TextSpan(text: 'なんたらかんたら。うんたらかんたら。\n'),
            ],
          ),
          textScaler: TextScaler.linear(1.0),
        ),
      ],
    );
  }
}
