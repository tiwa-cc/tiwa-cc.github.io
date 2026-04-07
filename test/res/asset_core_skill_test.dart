import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/res/asset_core_skill.dart';

void main() {
  group('AssetCoreSkill', () {
    test('resolves Japanese asset path', () {
      expect(
        AssetCoreSkill.pathFor(const Locale('ja')),
        anyOf('mock/core_skill.ja.json', 'assets/mock/core_skill.ja.json'),
      );
    });

    test('resolves English asset path', () {
      expect(
        AssetCoreSkill.pathFor(const Locale('en')),
        anyOf('mock/core_skill.en.json', 'assets/mock/core_skill.en.json'),
      );
    });
  });
}
