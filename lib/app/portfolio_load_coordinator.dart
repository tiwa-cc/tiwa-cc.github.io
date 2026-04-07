import 'dart:async';

typedef PortfolioLoadTask = Future<void> Function();

enum PortfolioLoadPhase { idle, loading, ready, failed }

final class PortfolioLoadException implements Exception {
  const PortfolioLoadException({
    required this.cause,
    required this.attempts,
    required this.didTimeout,
  });

  final Object cause;
  final int attempts;
  final bool didTimeout;

  @override
  String toString() {
    return 'PortfolioLoadException('
        'attempts: $attempts, '
        'didTimeout: $didTimeout, '
        'cause: $cause'
        ')';
  }
}

final class PortfolioLoadCoordinator {
  const PortfolioLoadCoordinator({
    this.timeout = const Duration(seconds: 4),
    this.maxAttempts = 2,
  });

  final Duration timeout;
  final int maxAttempts;

  Future<void> load(List<PortfolioLoadTask> tasks) async {
    if (tasks.isEmpty) {
      return;
    }

    Object? lastError;
    StackTrace? lastStackTrace;
    var didTimeout = false;
    var attemptedCount = 0;

    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      attemptedCount = attempt;
      try {
        await Future.wait(
          tasks.map((task) => task().timeout(timeout)),
          eagerError: true,
        );
        return;
      } on TimeoutException catch (error, stackTrace) {
        lastError = error;
        lastStackTrace = stackTrace;
        didTimeout = true;

        if (attempt < maxAttempts) {
          continue;
        }
      } catch (error, stackTrace) {
        lastError = error;
        lastStackTrace = stackTrace;
        didTimeout = false;
        break;
      }
    }

    final failure = PortfolioLoadException(
      cause: lastError ?? StateError('Unknown portfolio load error'),
      attempts: attemptedCount,
      didTimeout: didTimeout,
    );
    Error.throwWithStackTrace(failure, lastStackTrace ?? StackTrace.current);
  }
}
