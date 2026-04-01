import 'result.dart';

/// Base abstract class for all UseCases.
/// Enforces a consistent interface with a [call] method.
abstract class UseCase<R, P> {
  Future<Result<R>> call(P params);
}

/// Helper class for UseCases that don't require any parameters.
class NoParams {}
