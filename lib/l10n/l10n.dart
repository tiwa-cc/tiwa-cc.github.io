import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Custom localization loader for environments where generated l10n code is
/// not reliable, such as Flutter WASM.
class L10n {
  L10n._({required this.locale, required Map<String, String> messages})
    : _messages = Map.unmodifiable(messages);

  final Locale locale;
  final Map<String, String> _messages;

  static const Locale fallbackLocale = Locale('en');
  static const Locale englishLocale = Locale('en');
  static const Locale japaneseLocale = Locale('ja');

  static const List<Locale> supportedLocales = <Locale>[
    englishLocale,
    japaneseLocale,
  ];

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _L10nDelegate(),
      ];

  static L10n of(BuildContext context) {
    final l10n = Localizations.of<L10n>(context, L10n);
    assert(
      l10n != null,
      'L10n is not available in this BuildContext. '
      'Wrap the widget tree with MaterialApp using '
      'L10n.localizationsDelegates and L10n.supportedLocales.',
    );
    return l10n!;
  }

  static Locale resolveLocale(Locale? locale) {
    if (locale == null) {
      return fallbackLocale;
    }

    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }

    return fallbackLocale;
  }

  static Locale resolveLocaleList(
    List<Locale>? locales,
    Iterable<Locale> supportedLocales,
  ) {
    for (final locale in locales ?? const <Locale>[]) {
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return supportedLocale;
        }
      }
    }

    return fallbackLocale;
  }

  static Future<L10n> load(Locale locale) async {
    final resolvedLocale = resolveLocale(locale);
    final raw = await rootBundle.loadString(
      'l10n/messages.${resolvedLocale.languageCode}.json',
    );
    final data = json.decode(raw);

    if (data is! Map<String, dynamic>) {
      throw FlutterError(
        'Localization asset for ${resolvedLocale.languageCode} '
        'must decode to a JSON object.',
      );
    }

    return L10n._(
      locale: resolvedLocale,
      messages: data.map(
        (key, value) => MapEntry(key, value?.toString() ?? ''),
      ),
    );
  }

  String _text(String key) {
    final message = _messages[key];
    assert(
      message != null,
      'Missing localization key "$key" for ${locale.languageCode}.',
    );
    return message ?? key;
  }

  String get brandName => _text('brandName');
  String get portfolioLoadErrorTitle => _text('portfolioLoadErrorTitle');
  String get portfolioLoadErrorDescription =>
      _text('portfolioLoadErrorDescription');
  String get retryLabel => _text('retryLabel');
  String get aboutTitle => _text('aboutTitle');
  String get aboutEmptyMessage => _text('aboutEmptyMessage');
  String get aboutLoadError => _text('aboutLoadError');
  String get contactTitle => _text('contactTitle');
  String get profileTitle => _text('profileTitle');
  String get profileImageLabel => _text('profileImageLabel');
  String get profileRole => _text('profileRole');
  String get profileLead => _text('profileLead');
  String get profileFocusArchitecture => _text('profileFocusArchitecture');
  String get profileFocusDelivery => _text('profileFocusDelivery');
  String get profileFocusCrossDomain => _text('profileFocusCrossDomain');
  String get experienceTitle => _text('experienceTitle');
  String get coreSkillTitle => _text('coreSkillTitle');
  String get coreSkillEmptyMessage => _text('coreSkillEmptyMessage');
  String get coreSkillLoadError => _text('coreSkillLoadError');
  String get contentsTitle => _text('contentsTitle');
  String get contentsEmptyMessage => _text('contentsEmptyMessage');
  String get contentsLoadError => _text('contentsLoadError');
  String get softwareSkillTitle => _text('softwareSkillTitle');
  String get softwareSkillEmptyMessage => _text('softwareSkillEmptyMessage');
  String get softwareSkillLoadError => _text('softwareSkillLoadError');
  String get softwareSkillPrimaryLabel => _text('softwareSkillPrimaryLabel');
  String get softwareSkillDeliveryLabel => _text('softwareSkillDeliveryLabel');
  String get softwareSkillCrossDomainLabel =>
      _text('softwareSkillCrossDomainLabel');
  String get softwareSkillAdditionalLabel =>
      _text('softwareSkillAdditionalLabel');
  String get softwareSkillCategoryDevelopmentTools =>
      _text('softwareSkillCategoryDevelopmentTools');
  String get softwareSkillCategoryLanguages =>
      _text('softwareSkillCategoryLanguages');
  String get softwareSkillCategoryFrameworks =>
      _text('softwareSkillCategoryFrameworks');
  String get softwareSkillCategoryMarkupDocs =>
      _text('softwareSkillCategoryMarkupDocs');
  String get softwareSkillCategoryCloudInfrastructure =>
      _text('softwareSkillCategoryCloudInfrastructure');
  String get softwareSkillCategoryProtocols =>
      _text('softwareSkillCategoryProtocols');
  String get softwareSkillCategoryPlatforms =>
      _text('softwareSkillCategoryPlatforms');
  String get softwareSkillCategoryOther => _text('softwareSkillCategoryOther');
  String get copyrightPrefix => _text('copyrightPrefix');
  String get author => _text('author');
  String get location => _text('location');
  String get emailAccount => _text('emailAccount');
  String get xAccount => _text('xAccount');
  String get xUri => _text('xUri');
  String get linkedInAccount => _text('linkedInAccount');
  String get linkedInUri => _text('linkedInUri');
  String get experienceEmptyMessage => _text('experienceEmptyMessage');
  String get experienceLoadError => _text('experienceLoadError');
  String get experienceTechnologiesLabel =>
      _text('experienceTechnologiesLabel');
  String get experienceCurrentLabel => _text('experienceCurrentLabel');
  String get dateRangeSeparator => _text('dateRangeSeparator');
  String get scrollToTopLabel => _text('scrollToTopLabel');
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  bool isSupported(Locale locale) {
    return L10n.supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }

  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}
