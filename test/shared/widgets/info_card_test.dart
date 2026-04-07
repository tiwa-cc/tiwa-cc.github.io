import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/shared/themes/info_card_theme.dart';
import 'package:my_portfolio/shared/widgets/info_card.dart';

void main() {
  testWidgets('uses the configured info card theme extension', (tester) async {
    const titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
    const subtitleStyle = TextStyle(fontSize: 14, fontStyle: FontStyle.italic);
    const durationStyle = TextStyle(fontSize: 12, color: Colors.teal);

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const <ThemeExtension<dynamic>>[
            InfoCardTheme(
              titleStyle: titleStyle,
              subtitleStyle: subtitleStyle,
              durationStyle: durationStyle,
            ),
          ],
        ),
        home: const Scaffold(
          body: InfoCard(
            title: 'Senior Engineer',
            subtitle: 'Example Corp',
            duration: '2020-2024',
            details: <String>['Built portfolio features'],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.widget<Text>(find.text('Senior Engineer')).style, titleStyle);
    expect(tester.widget<Text>(find.text('Example Corp')).style, subtitleStyle);
    expect(tester.widget<Text>(find.text('2020-2024')).style, durationStyle);
  });
}
