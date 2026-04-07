import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/top_view.dart';
import 'package:my_portfolio/infrastructure/communicate/raw_client.dart';
import 'package:my_portfolio/infrastructure/storage/raw_accessor.dart';
import 'package:my_portfolio/shared/providers.dart';

void main() {
  testWidgets('renders portfolio sections with raw asset data at md', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(1024, 1200);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          serverApiProvider.overrideWith((ref) => RawClient(ref: ref)),
          storageAccessProvider.overrideWith((ref) => RawAccessor()),
          localeOverrideProvider.overrideWith((ref) => const Locale('ja')),
        ],
        child: const TopView(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(find.text('代表的な取り組み', findRichText: true), findsOneWidget);
    expect(find.text('tiwa-cc'), findsOneWidget);
    expect(find.text('Portfolio Platform'), findsOneWidget);
  });
}
