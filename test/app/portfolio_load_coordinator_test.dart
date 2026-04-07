import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/portfolio_load_coordinator.dart';

void main() {
  group('PortfolioLoadCoordinator', () {
    test('retries once after a timeout and then succeeds', () async {
      final coordinator = PortfolioLoadCoordinator(
        timeout: const Duration(milliseconds: 10),
      );
      var attempts = 0;

      await coordinator.load([
        () async {
          attempts += 1;
          if (attempts == 1) {
            await Completer<void>().future;
          }
        },
      ]);

      expect(attempts, 2);
    });

    test('throws after the retry also times out', () async {
      final coordinator = PortfolioLoadCoordinator(
        timeout: const Duration(milliseconds: 10),
      );

      await expectLater(
        coordinator.load([
          () async {
            await Completer<void>().future;
          },
        ]),
        throwsA(
          isA<PortfolioLoadException>()
              .having((error) => error.didTimeout, 'didTimeout', isTrue)
              .having((error) => error.attempts, 'attempts', 2),
        ),
      );
    });

    test('fails immediately on a non-timeout error', () async {
      final coordinator = PortfolioLoadCoordinator(
        timeout: const Duration(milliseconds: 10),
      );
      var attempts = 0;

      await expectLater(
        coordinator.load([
          () async {
            attempts += 1;
            throw StateError('boom');
          },
        ]),
        throwsA(
          isA<PortfolioLoadException>()
              .having((error) => error.didTimeout, 'didTimeout', isFalse)
              .having((error) => error.attempts, 'attempts', 1),
        ),
      );
      expect(attempts, 1);
    });
  });
}
