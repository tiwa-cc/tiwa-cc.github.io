import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/features/header/header_popup_menu.dart';
import 'package:my_portfolio/shared/themes/header_popup_menu_theme.dart';

void main() {
  testWidgets('uses the configured popup menu theme extension', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const <ThemeExtension<dynamic>>[
            HeaderPopupMenuTheme(
              menuIconData: Icons.more_horiz,
              menuIconColor: Colors.orange,
              menuBackgroundColor: Colors.blue,
            ),
          ],
        ),
        home: const Scaffold(
          body: HeaderPopupMenu(actions: <Widget>[Text('Action')]),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final popupMenu = tester.widget<PopupMenuButton<dynamic>>(
      find.byWidgetPredicate((widget) => widget is PopupMenuButton<dynamic>),
    );

    expect((popupMenu.icon as Icon).icon, Icons.more_horiz);
    expect(popupMenu.iconColor, Colors.orange);
    expect(popupMenu.color, Colors.blue);
  });
}
