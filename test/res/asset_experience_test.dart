import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/res/asset_experience.dart';

void main() {
  group('AssetExperience', () {
    test('resolves Japanese asset path', () {
      expect(
        AssetExperience.pathFor(const Locale('ja')),
        anyOf('mock/experience.ja.json', 'assets/mock/experience.ja.json'),
      );
    });

    test('resolves English asset path', () {
      expect(
        AssetExperience.pathFor(const Locale('en')),
        anyOf('mock/experience.en.json', 'assets/mock/experience.en.json'),
      );
    });
  });
}
