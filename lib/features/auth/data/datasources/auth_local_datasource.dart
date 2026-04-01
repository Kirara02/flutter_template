import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/auth/token_manager.dart';

part 'auth_local_datasource.g.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
  Future<void> deleteRefreshToken();
  Future<void> clearAll();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final TokenManager _tokenManager;

  AuthLocalDataSourceImpl(this._tokenManager);

  @override
  Future<void> saveToken(String token) => _tokenManager.writeAccessToken(token);

  @override
  Future<String?> getToken() => _tokenManager.accessToken;

  @override
  Future<void> deleteToken() => _tokenManager.deleteAccessToken();

  @override
  Future<void> saveRefreshToken(String token) =>
      _tokenManager.writeRefreshToken(token);

  @override
  Future<String?> getRefreshToken() => _tokenManager.refreshToken;

  @override
  Future<void> deleteRefreshToken() => _tokenManager.deleteRefreshToken();

  @override
  Future<void> clearAll() => _tokenManager.clearTokens();
}

@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  return AuthLocalDataSourceImpl(ref.watch(tokenManagerProvider));
}
