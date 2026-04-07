import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/layout_width_dropdown_button.dart';
import 'package:my_portfolio/shared/parts/layout_width_preset.dart';
import 'package:my_portfolio/shared/providers.dart';

void main() {
  testWidgets('updates the selected layout width preset', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(body: LayoutWidthDropdownButton()),
        ),
      ),
    );

    expect(container.read(layoutWidthPresetProvider), LayoutWidthPreset.auto);
    expect(find.text('Auto'), findsOneWidget);

    await tester.tap(find.byType(DropdownButton<LayoutWidthPreset>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('XS (375px)').last);
    await tester.pumpAndSettle();

    expect(container.read(layoutWidthPresetProvider), LayoutWidthPreset.xs);
    expect(find.text('XS'), findsOneWidget);
  });
}
