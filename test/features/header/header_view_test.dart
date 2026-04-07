import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/features/header/header_popup_menu.dart';
import 'package:my_portfolio/features/header/header_view.dart';
import 'package:my_portfolio/shared/parts/breakpoint.dart';

void main() {
  test('uses a popup menu plus utility actions at the sm breakpoint', () {
    final actions = HeaderView.resolveActions(
      breakpoint: Breakpoint.sm,
      navigationActions: const [Text('Profile'), Text('About')],
      utilityActions: const [Text('Utility')],
    );

    expect(actions, hasLength(2));
    expect(actions.first, isA<HeaderPopupMenu>());
    expect(actions.last, isA<Text>());
  });

  test('uses a popup menu plus utility actions at the xs breakpoint', () {
    final actions = HeaderView.resolveActions(
      breakpoint: Breakpoint.xs,
      navigationActions: const [Text('Profile'), Text('About')],
      utilityActions: const [Text('Utility')],
    );

    expect(actions, hasLength(2));
    expect(actions.first, isA<HeaderPopupMenu>());
    expect(actions.last, isA<Text>());
  });
}
