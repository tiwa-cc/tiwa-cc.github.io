import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/providers.dart';

class LocaleToggleButton extends ConsumerWidget {
  const LocaleToggleButton({super.key});

  static const Map<String, String> _labels = <String, String>{
    'en': 'English',
    'ja': '日本語',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = L10n.of(context).locale;
    final nextLocale =
        currentLocale.languageCode == L10n.japaneseLocale.languageCode
        ? L10n.englishLocale
        : L10n.japaneseLocale;

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.yellow,
        shadowColor: Colors.blueGrey,
      ),
      onPressed: () {
        ref.read(localeOverrideProvider.notifier).state = nextLocale;
      },
      child: Text(_labels[nextLocale.languageCode] ?? nextLocale.languageCode),
    );
  }
}
