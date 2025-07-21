import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A class that provides localized strings for the application.
class L10n {
  L10n();

  static L10n? of(BuildContext context) => L10n();
  static get localizationsDelegates => null;
  static get supportedLocales => const <Locale>[
    // Locale('ja', 'JP'),
    Locale('en', 'US'),
  ];

  String get title => Intl.message('Create&Creative');
  String get aboutTitle => Intl.message('ABOUT');
}
