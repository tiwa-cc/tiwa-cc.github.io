import 'package:flutter/material.dart';
import 'package:my_portfolio/shared/themes/header_popup_menu_theme.dart';

class HeaderPopupMenu extends StatelessWidget {
  final List<Widget> actions;

  const HeaderPopupMenu({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    final theme = HeaderPopupMenuTheme.theme(context);

    return PopupMenuButton(
      icon: Icon(theme.menuIconData),
      iconColor: theme.menuIconColor,
      color: theme.menuBackgroundColor,
      itemBuilder: (BuildContext context) =>
          actions.map((widget) => PopupMenuItem(child: widget)).toList(),
    );
  }
}
