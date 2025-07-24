import 'package:flutter/material.dart';
import 'package:my_portfolio/features/footer/themes/footer_brand_name_theme.dart';
import 'package:my_portfolio/features/footer/themes/footer_copyright_style.dart';
import 'package:my_portfolio/l10n/l10n.dart';

class FooterView extends StatelessWidget {
  const FooterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final copyrightTheme = FooterCopyrightTheme.theme(context);
    final brandNameTheme = FooterBrandNameTheme.theme(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color.fromRGBO(21, 25, 29, 1),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: l10n.copyrightPrefix, style: copyrightTheme.style),
            const TextSpan(text: ' '),
            TextSpan(text: l10n.brandName, style: brandNameTheme.style),
          ],
        ),
      ),
    );
  }
}
