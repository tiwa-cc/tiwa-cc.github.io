import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/domain/content_entry.dart';
import 'package:my_portfolio/features/contents/contents_panel.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/providers.dart';
import 'package:my_portfolio/shared/themes/app_theme_data.dart';

void main() {
  group('ContentsPanel', () {
    testWidgets('renders loading, empty, data, and error states in English', (
      tester,
    ) async {
      final loadingController = StreamController<List<ContentEntry>>();
      var subject = _buildSubject(loadingController.stream);

      await tester.pumpWidget(subject.widget);
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await _disposeSubject(tester, subject);
      await loadingController.close();

      subject = _buildSubject(Stream.value(<ContentEntry>[]));
      await tester.pumpWidget(subject.widget);
      await tester.pump();
      await tester.pump();

      expect(find.text('No content data is available yet.'), findsOneWidget);

      await _disposeSubject(tester, subject);

      subject = _buildSubject(
        Stream.value([
          const ContentEntry(
            title: 'Create&Creative Portfolio',
            summary: 'This portfolio site itself.',
            tags: ['Flutter Web', 'GitHub Pages'],
            details: ['Single-page layout.', 'Responsive sections.'],
            links: [
              ContentLink(
                label: 'Open Site',
                url: 'https://tiwa-cc.github.io/',
                kind: 'live',
              ),
              ContentLink(
                label: 'Repository',
                url: 'https://github.com/tiwa-cc/tiwa-cc.github.io',
                kind: 'source',
              ),
            ],
          ),
          const ContentEntry(
            title: 'React Demo Site',
            summary: 'A public demo site built with React.',
            tags: ['React', 'Vercel'],
            details: ['Hosted on Vercel.'],
            links: [
              ContentLink(
                label: 'Open Site',
                url: 'https://tiwa-cc-workforce.vercel.app/',
                kind: 'live',
              ),
            ],
          ),
        ]),
      );
      await tester.pumpWidget(subject.widget);
      await tester.pumpAndSettle();

      expect(find.text('Featured Work', findRichText: true), findsOneWidget);
      expect(find.text('Create&Creative Portfolio'), findsOneWidget);
      expect(find.text('React Demo Site'), findsOneWidget);
      expect(find.text('Open Site'), findsNWidgets(2));
      expect(find.text('Repository'), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(2));

      await _disposeSubject(tester, subject);

      subject = _buildSubject(
        Stream<List<ContentEntry>>.error(StateError('boom')),
      );
      await tester.pumpWidget(subject.widget);
      await tester.pump();
      await tester.pump();

      expect(find.text('Failed to load content data.'), findsOneWidget);

      await _disposeSubject(tester, subject);
    });

    testWidgets('renders localized content data in Japanese', (tester) async {
      final subject = _buildSubject(
        Stream.value([
          const ContentEntry(
            title: 'Create&Creative Portfolio',
            summary: 'このポートフォリオサイト自体です。',
            tags: ['Flutter Web', 'GitHub Pages'],
            details: ['1 ページ構成です。'],
            links: [
              ContentLink(
                label: '公開サイト',
                url: 'https://tiwa-cc.github.io/',
                kind: 'live',
              ),
            ],
          ),
        ]),
        locale: const Locale('ja'),
      );

      await tester.pumpWidget(subject.widget);
      await tester.pumpAndSettle();

      expect(find.text('代表的な取り組み', findRichText: true), findsOneWidget);
      expect(find.text('このポートフォリオサイト自体です。'), findsOneWidget);
      expect(find.text('公開サイト'), findsOneWidget);

      await _disposeSubject(tester, subject);
    });
  });
}

({ProviderContainer container, Widget widget}) _buildSubject(
  Stream<List<ContentEntry>> stream, {
  Locale locale = const Locale('en'),
}) {
  final container = ProviderContainer(
    overrides: [contentEntryListProvider.overrideWith((ref) => stream)],
  );

  return (
    container: container,
    widget: UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        key: UniqueKey(),
        locale: locale,
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        theme: AppThemeData.themeData,
        home: const Scaffold(
          body: SingleChildScrollView(child: ContentsPanel()),
        ),
      ),
    ),
  );
}

Future<void> _disposeSubject(
  WidgetTester tester,
  ({ProviderContainer container, Widget widget}) subject,
) async {
  subject.container.dispose();
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
}
