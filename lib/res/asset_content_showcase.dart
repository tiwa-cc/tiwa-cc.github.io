import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/res/asset_path.dart';

final class AssetContentShowcase {
  const AssetContentShowcase({required this.locale});

  final Locale locale;

  static String pathFor(Locale locale) {
    final resolvedLocale = L10n.resolveLocale(locale);
    return resolveAssetPath(
      'mock/content_showcase.${resolvedLocale.languageCode}.json',
    );
  }

  String get path => pathFor(locale);

  Future<Map<String, dynamic>> decodedJson() async {
    final json = await rootBundle.loadString(path);
    final map = jsonDecode(json) as Map<String, dynamic>;
    return map;
  }
}
