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

  String get brandName => Intl.message('Create&Creative');
  String get aboutTitle => Intl.message('ABOUT');
  String get contactTitle => Intl.message('CONTACT');
  String get portfolioTitle => Intl.message('PORTFOLIO');
  String get profileTitle => Intl.message('PROFILE');
  String get educationTitle => Intl.message('Education');
  String get experienceTitle => Intl.message('Experience');
  String get coreSkillTitle => Intl.message('Core Skills');
  String get softwareSkillTitle => Intl.message('Software Skills');
  String get copyrightPrefix => Intl.message('Copyright © 2025');

  String get author => Intl.message('tiwa-cc');
  String get location => Intl.message('Fukuoka, Japan');
  String get emailAccount => Intl.message('');
  String get xAccount => Intl.message('@tiwa-cc');
  String get linkedInAccount => Intl.message('');
}
