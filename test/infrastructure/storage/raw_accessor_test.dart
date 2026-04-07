import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/domain/about.dart';
import 'package:my_portfolio/domain/content_entry.dart';
import 'package:my_portfolio/infrastructure/storage/raw_accessor.dart';

void main() {
  group('RawAccessor', () {
    test('replays the latest content entries to a late subscriber', () async {
      final accessor = RawAccessor();
      const firstEntry = ContentEntry(
        title: 'Responsive layout preview',
        summary: 'Preview multiple breakpoints',
        tags: ['flutter'],
        details: ['Check XS to XL layout changes.'],
        links: [
          ContentLink(
            label: 'Preview',
            url: 'https://example.com/preview',
            kind: 'demo',
          ),
        ],
      );

      accessor.replaceContentEntryList(const [firstEntry]);

      await expectLater(
        accessor.watchContentEntryList().first,
        completion(equals(const [firstEntry])),
      );
    });

    test('stays pending before about data has been loaded', () async {
      final accessor = RawAccessor();
      var completed = false;

      unawaited(
        accessor.watchAbout().first.then((_) {
          completed = true;
        }),
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(completed, isFalse);

      accessor.replaceAbout(
        const About(
          paragraphs: ['Build reliable UI state around late subscribers.'],
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(completed, isTrue);
    });
  });
}
