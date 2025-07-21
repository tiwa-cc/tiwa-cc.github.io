import 'package:flutter/material.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/widgets/header_view_button_style.dart';

final class ContactViewButton extends StatelessWidget {
  const ContactViewButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final style = HeaderViewButtonStyle();
    return TextButton(
      style: style,
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
