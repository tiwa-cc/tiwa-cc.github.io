import 'package:flutter/material.dart';
import 'package:my_portfolio/app/section.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/themes/header_view_button_theme.dart';

final class SectionViewButton extends StatelessWidget {
  const SectionViewButton({
    super.key,
    required this.section,
    required this.onPressed,
  });

  final Section section;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final theme = HeaderViewButtonTheme.theme(context);

    return TextButton(
      style: theme.style,
      onPressed: onPressed,
      child: Text(section.title(l10n).toUpperCase()),
    );
  }
}
