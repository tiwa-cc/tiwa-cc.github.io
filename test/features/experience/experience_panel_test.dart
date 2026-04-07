import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/domain/experience.dart';
import 'package:my_portfolio/features/experience/experience_panel.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/providers.dart';

void main() {
  group('ExperiencePanel', () {
    testWidgets('renders loading, empty, data, and error states in Japanese', (
      tester,
    ) async {
      final loadingController = StreamController<List<Experience>>();
      var subject = _buildSubject(loadingController.stream);

      await tester.pumpWidget(subject.widget);
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await _disposeSubject(tester, subject);
      await loadingController.close();

      subject = _buildSubject(Stream.value(<Experience>[]));
      await tester.pumpWidget(subject.widget);
      await tester.pump();
      await tester.pump();

      expect(find.text('表示できる経験データはまだありません。'), findsOneWidget);

      await _disposeSubject(tester, subject);

      final experiences = [
        const Experience(
          title: 'Mobile / Client Experience',
          summary: '利用体験に近い層の実装と検証',
          startedAt: '2006-04-01',
          endedAt: '2014-06-30',
          highlights: ['UI 実装、表示制御、端末連携など利用体験に近い層を担当'],
          technologies: ['Mobile Apps', 'UI Implementation'],
        ),
        const Experience(
          title: 'Web / Product Delivery',
          summary: '要件整理から運用改善までをつなぐ開発',
          startedAt: '2009-01-01',
          endedAt: '2026-03-31',
          highlights: ['要件整理、設計、実装、本番対応、運用改善まで一気通貫で担当'],
          technologies: [
            'Web Frontend',
            'Backend / API',
            'Cloud / Infrastructure',
          ],
        ),
      ];
      subject = _buildSubject(Stream.value(experiences));
      await tester.pumpWidget(subject.widget);
      await tester.pump();
      await tester.pump();

      expect(find.text('2009.01 ～ 2026.03'), findsOneWidget);
      expect(find.text('2006.04 ～ 2014.06'), findsOneWidget);
      expect(find.text('Backend / API'), findsOneWidget);
      expect(find.text('Cloud / Infrastructure'), findsOneWidget);

      expect(find.byType(Card), findsNWidgets(2));
      expect(find.text('Web / Product Delivery'), findsOneWidget);

      await _disposeSubject(tester, subject);

      subject = _buildSubject(
        Stream<List<Experience>>.error(StateError('boom')),
      );
      await tester.pumpWidget(subject.widget);
      await tester.pump();
      await tester.pump();

      expect(find.text('経験データの読み込みに失敗しました。'), findsOneWidget);

      await _disposeSubject(tester, subject);
    });

    testWidgets('shows English localized messages when locale is English', (
      tester,
    ) async {
      final subject = _buildSubject(
        Stream.value(<Experience>[]),
        locale: const Locale('en'),
      );

      await tester.pumpWidget(subject.widget);
      await tester.pump();
      await tester.pump();

      expect(find.text('No experience data is available yet.'), findsOneWidget);

      await _disposeSubject(tester, subject);
    });
  });
}

({ProviderContainer container, Widget widget}) _buildSubject(
  Stream<List<Experience>> stream, {
  Locale locale = const Locale('ja'),
}) {
  final container = ProviderContainer(
    overrides: [experienceListProvider.overrideWith((ref) => stream)],
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
        home: const Scaffold(body: ExperiencePanel()),
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
