import 'package:flutter/material.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/res/asset_profile.dart';
import 'package:my_portfolio/shared/themes/author_name_theme.dart';
import 'package:my_portfolio/shared/widgets/card_title.dart';

class ProfilePanel extends StatelessWidget {
  const ProfilePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final authorNameTheme = AuthorNameTheme.theme(context);
    final theme = Theme.of(context);
    final roleStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: theme.colorScheme.primary,
    );
    final leadStyle = theme.textTheme.bodyLarge?.copyWith(height: 1.5);
    final locationStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final focusLabels = [
      l10n.profileFocusArchitecture,
      l10n.profileFocusDelivery,
      l10n.profileFocusCrossDomain,
    ];

    final profileImage = SizedBox(
      width: 180,
      child: Semantics(
        container: true,
        image: true,
        label: l10n.profileImageLabel,
        child: ExcludeSemantics(child: AssetProfile().image),
      ),
    );

    final profileBody = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitle(title: l10n.profileTitle),
        const SizedBox(height: 16),
        Text(l10n.profileRole, style: roleStyle),
        const SizedBox(height: 8),
        Semantics(
          container: true,
          header: true,
          child: Text(l10n.author, style: authorNameTheme.style),
        ),
        const SizedBox(height: 12),
        Text(l10n.profileLead, style: leadStyle),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: focusLabels
              .map(
                (label) => Chip(
                  label: Text(label),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
              )
              .toList(growable: false),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(l10n.location, style: locationStyle)),
          ],
        ),
      ],
    );

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 640;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  profileImage,
                  const SizedBox(width: 24),
                  Expanded(child: profileBody),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: profileImage),
                const SizedBox(height: 20),
                profileBody,
              ],
            );
          },
        ),
      ),
    );
  }
}
