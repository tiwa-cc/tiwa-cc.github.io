import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/l10n/l10n.dart';
import 'package:my_portfolio/shared/widgets/scroll_to_head_button.dart';

void main() {
  testWidgets('renders a right-aligned text button with localized label', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ja'),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: Scaffold(
          body: ScrollToHeadButton(
            onHeader: () {
              tapped = true;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ElevatedButton), findsNothing);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.text('ページ上部へ戻る'), findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Align &&
            widget.alignment == Alignment.centerRight &&
            widget.child is TextButton,
      ),
      findsOneWidget,
    );

    await tester.tap(find.byType(TextButton));
    expect(tapped, isTrue);
  });
}
