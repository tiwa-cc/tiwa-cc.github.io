import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/l10n/l10n.dart';

class ContactPanel extends StatelessWidget {
  final VoidCallback onHeader;

  const ContactPanel({super.key, required this.onHeader});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;

    final contactList = [
      ContactListData(
        icon: Icons.location_on,
        title: l10n.location,
        onTap: null,
      ),
      ContactListData(icon: Icons.email, title: l10n.emailAccount, onTap: null),
      ContactListData(
        icon: FontAwesomeIcons.xTwitter,
        title: l10n.xAccount,
        onTap: null,
      ),
      ContactListData(
        icon: FontAwesomeIcons.linkedin,
        title: l10n.linkedInAccount,
        onTap: null,
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ScrollToHeadButton(onHeader: onHeader),
        // CardTitle(title: l10n.contactTitle),
        ...contactList.map(
          (contact) => ListTile(
            leading: FaIcon(contact.icon),
            title: Text(contact.title),
            onTap: contact.onTap,
          ),
        ),
      ],
    );
  }
}

class ContactListData {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  ContactListData({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
