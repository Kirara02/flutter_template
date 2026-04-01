import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_service.g.dart';

/// Typed wrapper around [FlutterSecureStorage].
///
/// All token and credential persistence must go through this service —
/// raw [FlutterSecureStorage] should never be used directly in the rest of the app.
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(),
            iOptions: IOSOptions(
              accessibility: KeychainAccessibility.unlocked_this_device,
            ),
          );

  final FlutterSecureStorage _storage;

  /// Persists [value] under [key]. Both must be non-empty.
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  /// Returns the value stored under [key], or `null` if absent.
  Future<String?> read(String key) => _storage.read(key: key);

  /// Removes the entry for [key]. No-op if the key does not exist.
  Future<void> delete(String key) => _storage.delete(key: key);

  /// Wipes all entries owned by this app.
  Future<void> deleteAll() => _storage.deleteAll();
}

@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(Ref ref) {
  return SecureStorageService();
}
