import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/res/asset_title.dart';
import 'package:my_portfolio/shared/themes/copyright_theme.dart';

class FooterView extends StatelessWidget {
  const FooterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final copyrightTheme = CopyrightTheme.theme(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color.fromRGBO(21, 25, 29, 1),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            Text(l10n.copyrightPrefix, style: copyrightTheme.style),
            _FooterBrandWordmark(semanticsLabel: l10n.brandName),
          ],
        ),
      ),
    );
  }
}

class _FooterBrandWordmark extends StatelessWidget {
  const _FooterBrandWordmark({required this.semanticsLabel});

  static const double _height = 12.0;

  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final asset = AssetTitle();

    return SizedBox(
      height: _height,
      child: AspectRatio(
        aspectRatio: asset.width / asset.height,
        child: SvgPicture.asset(
          asset.path,
          fit: BoxFit.contain,
          semanticsLabel: semanticsLabel,
        ),
      ),
    );
  }
}
