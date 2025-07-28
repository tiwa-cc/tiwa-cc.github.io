import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/l10n/l10n.dart';

class ContactPanel extends StatelessWidget {
  final VoidCallback onHeader;
final bool isListTile;

  const ContactPanel({
super.key,
required this.onHeader,
    this.isListTile = true,
});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;

    final contactList = [
      _ContactHolder(
        icon: Icons.location_on,
        title: l10n.location,
        onTap: () => {},
      ),
      _ContactHolder(
icon: Icons.email,
title: l10n.emailAccount,
onTap: () => {},
),
      _ContactHolder(
        icon: FontAwesomeIcons.xTwitter,
        title: l10n.xAccount,
        onTap: () => {},
      ),
      _ContactHolder(
        icon: FontAwesomeIcons.linkedin,
        title: l10n.linkedInAccount,
        onTap: () => {},
      ),
    ];

return isListTile
        ? _layoutListTile(contactList)
        : _layoutIconButton(contactList);
  }

  Widget _layoutListTile(List<_ContactHolder> contacts) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ScrollToHeadButton(onHeader: onHeader),
        // CardTitle(title: l10n.contactTitle),
        ...contacts.map(          (contact) => contact.getListTile()        ),
      ],
    );
  }

  Widget _layoutIconButton(List<_ContactHolder> contacts) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: contacts.map((contact) => contact.getIconButton()).toList(),
    );
  }
}

class _ContactHolder {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  _ContactHolder({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  Widget getListTile() {
    return ListTile(leading: FaIcon(icon), title: Text(title), onTap: onTap);
  }

  Widget getIconButton() {
    return IconButton(icon: FaIcon(icon), tooltip: title, onPressed: onTap);
  }
}
