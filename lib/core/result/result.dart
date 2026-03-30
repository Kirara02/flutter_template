import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

/// App-level sealed class representing the outcome of an operation.
/// Used extensively in Domain (UseCases) and Data (Repositories) layers.
@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T data, {String? message}) = Success<T>;
  const factory Result.failure(Exception error, [StackTrace? stackTrace]) =
      Failure<T>;
}

/// Extension to easily map functions returning Result
extension ResultExt<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => isSuccess ? (this as Success<T>).data : null;
  Exception? get errorOrNull => isFailure ? (this as Failure<T>).error : null;
}
