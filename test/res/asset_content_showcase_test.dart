import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/res/asset_content_showcase.dart';

void main() {
  group('AssetContentShowcase', () {
    test('resolves Japanese asset path', () {
      expect(
        AssetContentShowcase.pathFor(const Locale('ja')),
        anyOf(
          'mock/content_showcase.ja.json',
          'assets/mock/content_showcase.ja.json',
        ),
      );
    });

    test('resolves English asset path', () {
      expect(
        AssetContentShowcase.pathFor(const Locale('en')),
        anyOf(
          'mock/content_showcase.en.json',
          'assets/mock/content_showcase.en.json',
        ),
      );
    });
  });
}
