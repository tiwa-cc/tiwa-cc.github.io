import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/section.dart';
import 'package:my_portfolio/features/header/section_view_button.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/themes/header_view_button_theme.dart';

void main() {
  testWidgets('renders the localized section title with header button theme', (
    tester,
  ) async {
    final customStyle = ButtonStyle(
      foregroundColor: const WidgetStatePropertyAll<Color>(Colors.cyan),
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
        home: Scaffold(
          body: SectionViewButton(section: Section.contents, onPressed: () {}),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final button = tester.widget<TextButton>(find.byType(TextButton));

    expect(find.text('FEATURED WORK'), findsOneWidget);
    expect(
      button.style?.foregroundColor?.resolve(<WidgetState>{}),
      Colors.cyan,
    );
  });
}
