import 'package:flutter/material.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/widgets/header_view_button_style.dart';

final class AboutViewButton extends StatefulWidget {
  const AboutViewButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  State<AboutViewButton> createState() => _AboutViewButtonState();
}

class _AboutViewButtonState extends State<AboutViewButton> {
  final _statesController = WidgetStatesController(Set.of(WidgetState.values));

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final title = l10n.aboutTitle;
    final style = HeaderViewButtonStyle();
    return TextButton(
      style: style,
      statesController: _statesController,
      onPressed: _onPressed,
      child: Stack(alignment: Alignment.center, children: [Text(title)]),
    );
  }

  void _onPressed() {
    _statesController.update(WidgetState.selected, true);
    widget.onPressed.call();
  }
}
