import 'package:flutter/material.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/widgets/card_title.dart';

class CoreSkillPanel extends StatelessWidget {
  final VoidCallback onHeader;

  const CoreSkillPanel({super.key, required this.onHeader});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final title = l10n.coreSkillTitle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ScrollToHeadButton(onHeader: onHeader),
        CardTitle(title: title),
        ...List.generate(10, (index) => Text("${title}Panel")),
      ],
    );
  }
}
