import 'package:flutter/material.dart';

class HeaderViewButtonStyle extends ButtonStyle {
  HeaderViewButtonStyle()
    : super(
        foregroundColor: WidgetStateProperty.fromMap({
          WidgetState.any: Colors.yellow,
        }),
        shadowColor: WidgetStateProperty.fromMap({
          WidgetState.any: Colors.blueGrey,
        }),
      );
}
