import 'package:flutter/material.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/res/asset_profile.dart';
import 'package:my_portfolio/shared/widgets/card_title.dart';

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
        // ScrollToHeadButton(onHeader: onHeader),
        CardTitle(title: title),
        AssetProfile().image,
      ],
    );
  }
}
