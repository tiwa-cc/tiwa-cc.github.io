import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/shared/parts/layout_width_preset.dart';
import 'package:my_portfolio/shared/providers.dart';
import 'package:my_portfolio/shared/widgets/layout_width_frame.dart';

void main() {
  testWidgets('constrains the viewport width and media query size', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(1440, 900);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(layoutWidthPresetProvider.notifier).state =
        LayoutWidthPreset.xs;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: LayoutWidthFrame(
              child: Builder(
                builder: (context) {
                  final mediaQuerySize = MediaQuery.sizeOf(context);
                  return SizedBox.expand(
                    child: ColoredBox(
                      key: const Key('frame'),
                      color: Colors.black,
                      child: Text(
                        '${mediaQuerySize.width} x ${mediaQuerySize.height}',
                        key: const Key('media-query-size'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byKey(const Key('frame'))).width, 375);
    expect(find.text('375.0 x 900.0'), findsOneWidget);
  });
}
