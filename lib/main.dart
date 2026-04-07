import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/app/top_view.dart';
import 'package:my_portfolio/infrastructure/communicate/raw_client.dart';
import 'package:my_portfolio/infrastructure/storage/raw_accessor.dart';
import 'package:my_portfolio/shared/providers.dart';

void main() {
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'develop');

  runApp(
    ProviderScope(
      overrides: (flavor == 'develop')
          ? [
              serverApiProvider.overrideWith((ref) => RawClient(ref: ref)),
              storageAccessProvider.overrideWith((ref) => RawAccessor()),
            ]
          : [],
      child: const TopView(),
    ),
  );
}
