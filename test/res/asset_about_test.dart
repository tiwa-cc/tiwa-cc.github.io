import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/res/asset_about.dart';

void main() {
  group('AssetAbout', () {
    test('resolves Japanese asset path', () {
      expect(
        AssetAbout.pathFor(const Locale('ja')),
        anyOf('mock/about.ja.json', 'assets/mock/about.ja.json'),
      );
    });

    test('resolves English asset path', () {
      expect(
        AssetAbout.pathFor(const Locale('en')),
        anyOf('mock/about.en.json', 'assets/mock/about.en.json'),
      );
    });
  });
}
