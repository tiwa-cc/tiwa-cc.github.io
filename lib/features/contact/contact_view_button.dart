import 'package:flutter/material.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/themes/header_view_button_theme.dart';

final class ContactViewButton extends StatelessWidget {
  const ContactViewButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final theme = HeaderViewButtonTheme.theme(context);
    return TextButton(
      style: theme.style,
      onPressed: _onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [Text(l10n.contactTitle)],
      ),
    );
  }

  void _onPressed() {
    onPressed.call();
  }
}
