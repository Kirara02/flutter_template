import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'secure_storage_service.dart';

part 'token_manager.g.dart';

/// Storage keys — kept private to this file.
const _keyAccessToken = 'auth.access_token';
const _keyRefreshToken = 'auth.refresh_token';
const _keyTokenExpiry = 'auth.token_expiry'; // ISO-8601 string

/// Manages persistence and retrieval of auth tokens via [SecureStorageService].
///
/// All reads/writes are async because [FlutterSecureStorage] is async.
/// Token values are NEVER logged — callers must not log the returned strings.
class TokenManager {
  TokenManager(this._storage);

  final SecureStorageService _storage;

  // ---------------------------------------------------------------------------
  // Getters
  // ---------------------------------------------------------------------------

  /// The current access token, or `null` if not set.
  Future<String?> get accessToken => _storage.read(_keyAccessToken);

  /// The current refresh token, or `null` if not set.
  Future<String?> get refreshToken => _storage.read(_keyRefreshToken);

  /// Whether the stored access token is past its expiry timestamp.
  ///
  /// Returns `true` when no expiry is stored (treat as expired).
  Future<bool> get isTokenExpired async {
    final raw = await _storage.read(_keyTokenExpiry);
    if (raw == null) return true;
    final expiry = DateTime.tryParse(raw);
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry);
  }

  // ---------------------------------------------------------------------------
  // Mutations
  // ---------------------------------------------------------------------------

  /// Stores [access], [refresh], and [expiry] via parallel writes.
  ///
  /// NOTE — NOT truly atomic. Recovery path: [isTokenExpired] returns `true`
  /// when expiry is missing, so the app treats a partial write as an expired
  /// session.
  Future<void> saveTokens({
    required String access,
    required String refresh,
    required DateTime expiry,
  }) async {
    await Future.wait([
      writeAccessToken(access),
      writeRefreshToken(refresh),
      _storage.write(_keyTokenExpiry, expiry.toIso8601String()),
    ]);
  }

  /// Stores only the [access] token.
  Future<void> writeAccessToken(String token) =>
      _storage.write(_keyAccessToken, token);

  /// Stores only the [refresh] token.
  Future<void> writeRefreshToken(String token) =>
      _storage.write(_keyRefreshToken, token);

  /// Removes the access token.
  Future<void> deleteAccessToken() => _storage.delete(_keyAccessToken);

  /// Removes the refresh token.
  Future<void> deleteRefreshToken() => _storage.delete(_keyRefreshToken);

  /// Removes all stored token entries.
  Future<void> clearTokens() async {
    await Future.wait([
      deleteAccessToken(),
      deleteRefreshToken(),
      _storage.delete(_keyTokenExpiry),
    ]);
  }
}

@Riverpod(keepAlive: true)
TokenManager tokenManager(Ref ref) {
  return TokenManager(ref.watch(secureStorageServiceProvider));
}
