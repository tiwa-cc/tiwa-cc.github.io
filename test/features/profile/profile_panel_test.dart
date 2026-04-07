import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/features/profile/profile_panel.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/themes/app_theme_data.dart';
import 'package:my_portfolio/shared/themes/author_name_theme.dart';

void main() {
  group('ProfilePanel', () {
    testWidgets('renders author name with the configured theme extension', (
      tester,
    ) async {
      const customStyle = TextStyle(
        fontSize: 32,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w600,
      );

      await tester.pumpWidget(
        _buildSubject(
          theme: ThemeData(
            extensions: const <ThemeExtension<dynamic>>[
              AuthorNameTheme(style: customStyle),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      final author = tester.widget<Text>(find.text('tiwa-cc'));
      expect(author.style, customStyle);
    });

    testWidgets('exposes localized semantics for the profile image and name', (
      tester,
    ) async {
      final semanticsHandle = tester.ensureSemantics();
      try {
        await tester.pumpWidget(_buildSubject(locale: const Locale('ja')));
        await tester.pumpAndSettle();

        expect(find.text('tiwa-cc'), findsOneWidget);
        expect(
          tester.getSemantics(find.bySemanticsLabel('プロフィール画像')),
          matchesSemantics(label: 'プロフィール画像', isImage: true),
        );
        expect(
          tester.getSemantics(find.text('tiwa-cc')),
          matchesSemantics(label: 'tiwa-cc', isHeader: true),
        );
      } finally {
        semanticsHandle.dispose();
      }
    });
  });
}

Widget _buildSubject({Locale locale = const Locale('en'), ThemeData? theme}) {
  return MaterialApp(
    key: UniqueKey(),
    locale: locale,
    localizationsDelegates: L10n.localizationsDelegates,
    supportedLocales: L10n.supportedLocales,
    theme: theme ?? AppThemeData.themeData,
    home: const Scaffold(body: ProfilePanel()),
  );
}
