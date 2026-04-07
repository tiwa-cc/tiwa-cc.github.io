import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/widgets/card_title.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPanel extends StatelessWidget {
  const ContactPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final email = l10n.emailAccount.trim();
    final contacts = <_ContactHolder>[
      _ContactHolder(icon: Icons.location_on, title: l10n.location),
      _ContactHolder(
        icon: Icons.email,
        title: email,
        uri: email.isEmpty ? null : Uri(scheme: 'mailto', path: email),
      ),
      _ContactHolder(
        icon: FontAwesomeIcons.xTwitter,
        title: l10n.xAccount,
        uri: Uri.tryParse(l10n.xUri),
      ),
      _ContactHolder(
        icon: FontAwesomeIcons.linkedin,
        title: l10n.linkedInAccount,
        uri: Uri.tryParse(l10n.linkedInUri),
      ),
    ].where((contact) => contact.isVisible).toList(growable: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardTitle(title: l10n.contactTitle),
        const SizedBox(height: 12),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: contacts
                  .map((contact) => contact.buildAction())
                  .toList(growable: false),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactHolder {
  const _ContactHolder({required this.icon, required this.title, this.uri});

  final IconData icon;
  final String title;
  final Uri? uri;

  bool get isVisible => title.trim().isNotEmpty;

  Widget buildAction() {
    final iconWidget = FaIcon(icon, size: 16);
    if (uri == null) {
      return Chip(
        avatar: iconWidget,
        label: Text(title),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    return OutlinedButton.icon(
      onPressed: _handleTap,
      icon: iconWidget,
      label: Text(title),
    );
  }

  void _handleTap() {
    unawaited(_launchUri());
  }

  Future<void> _launchUri() async {
    final currentUri = uri;
    if (currentUri == null) {
      return;
    }

    await launchUrl(
      currentUri,
      webOnlyWindowName:
          currentUri.scheme == 'http' || currentUri.scheme == 'https'
          ? '_blank'
          : null,
    );
  }
}
