import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/base/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/requests/login_request.dart';
import '../models/user_model.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';

part 'auth_repository_impl.g.dart';

@riverpod
IAuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(authLocalDataSourceProvider),
  );
}

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<User>> login(LoginRequest request) async {
    final result = await _remoteDataSource.login(request.toMap());

    switch (result) {
      case Success(data: final payload):
        final token = payload['access_token'] as String?;
        final refreshToken = payload['refresh_token'] as String?;
        if (token != null) {
          await _localDataSource.saveToken(token);
        }
        if (refreshToken != null) {
          await _localDataSource.saveRefreshToken(refreshToken);
        }
        return Success(UserDto.fromMap(payload['user']).toDomain());
      case Failure(:final error, :final stackTrace):
        return Failure(error, stackTrace);
    }
  }

  @override
  Future<Result<User>> getProfile() async {
    final result = await _remoteDataSource.getProfile();

    switch (result) {
      case Success(data: final payload):
        return Success(UserDto.fromMap(payload).toDomain());
      case Failure(:final error, :final stackTrace):
        return Failure(error, stackTrace);
    }
  }

  @override
  Future<Result<void>> logout() async {
    final result = await _remoteDataSource.logout();

    // Always clear local tokens regardless of API result.
    // A token already expired or revoked on the server is still a valid logout.
    await _localDataSource.clearAll();

    return switch (result) {
      Success(:final message) => Success(null, message: message),
      Failure() => const Success(null), // treat as success — local state is cleared
    };
  }
}
