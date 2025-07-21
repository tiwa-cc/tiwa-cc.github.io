import 'package:flutter/material.dart';

class AboutViewButtonStyle extends ButtonStyle {
  AboutViewButtonStyle()
    : super(
        foregroundColor: WidgetStateProperty.fromMap({
          WidgetState.hovered: Colors.yellow,
          WidgetState.focused: Colors.yellow,
          WidgetState.scrolledUnder: Colors.yellow,
          WidgetState.selected: Colors.yellow,
          WidgetState.disabled: Colors.yellow,
          WidgetState.error: Colors.yellow,
        }),
        shadowColor: WidgetStateProperty.fromMap({
          WidgetState.any: Colors.blueGrey,
        }),
        side: WidgetStateProperty.fromMap({
          WidgetState.any: BorderSide(color: Colors.black, width: 2.0),
        }),
      );
}
