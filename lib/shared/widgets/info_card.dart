import 'package:flutter/material.dart';
import 'package:my_portfolio/shared/themes/info_card_theme.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? duration;
  final List<String> details;

  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final theme = InfoCardTheme.theme(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.titleStyle),
            if (subtitle != null) Text(subtitle!, style: theme.subtitleStyle),
            if (duration != null) Text(duration!, style: theme.durationStyle),
            if (details.isNotEmpty) const SizedBox(height: 8),
            ...details.map(
              (d) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• "),
                  Expanded(child: Text(d)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
