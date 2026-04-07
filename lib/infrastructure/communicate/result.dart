import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result {
  const factory Result.success(T data) = ResultSuccess;
  const factory Result.error(Object error, String message) = ResultError;
  const factory Result.timeout(String message) = ResultTimeout;
}
