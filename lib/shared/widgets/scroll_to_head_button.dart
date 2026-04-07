import 'package:flutter/material.dart';
import 'package:my_portfolio/l10n/l10n.dart';

final class ScrollToHeadButton extends StatelessWidget {
  const ScrollToHeadButton({super.key, required this.onHeader});

  final VoidCallback onHeader;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onHeader,
        child: Text(l10n.scrollToTopLabel),
      ),
    );
  }
}
