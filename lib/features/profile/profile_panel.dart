import 'package:flutter/material.dart';
import 'package:my_portfolio/features/profile/themes/profile_name_theme.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/res/asset_profile.dart';

class ProfilePanel extends StatelessWidget {
  final VoidCallback onHeader;

  const ProfilePanel({super.key, required this.onHeader});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ScrollToHeadButton(onHeader: onHeader),
        // CardTitle(title: l10n.profileTitle),
        AssetProfile().image,
        SizedBox(height: 8.0),
        Text(l10n.author, style: ProfileNameTheme.theme.style),
      ],
    );
  }
}
