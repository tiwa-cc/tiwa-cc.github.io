import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/features/about/about_view_button.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/themes/header_view_button_theme.dart';

void main() {
  testWidgets('uses the configured header button theme extension', (
    tester,
  ) async {
    final customStyle = ButtonStyle(
      foregroundColor: const WidgetStatePropertyAll<Color>(Colors.cyan),
      shadowColor: const WidgetStatePropertyAll<Color>(Colors.deepOrange),
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        theme: ThemeData(
          extensions: <ThemeExtension<dynamic>>[
            HeaderViewButtonTheme(style: customStyle),
          ],
        ),
        home: Scaffold(body: AboutViewButton(onPressed: () {})),
      ),
    );
    await tester.pumpAndSettle();

    final button = tester.widget<TextButton>(find.byType(TextButton));
    expect(
      button.style?.foregroundColor?.resolve(<WidgetState>{}),
      Colors.cyan,
    );
    expect(
      button.style?.shadowColor?.resolve(<WidgetState>{}),
      Colors.deepOrange,
    );
  });
}
