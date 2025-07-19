import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/app/top_view.dart';

void main() {
  runApp(ProviderScope(child: const TopView()));
}
