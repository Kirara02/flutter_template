import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/base/use_case.dart';
import '../../../../core/fcm/fcm_service.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../../../core/auth/session_manager.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/update_app_token_usecase.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AsyncValue<User?> build() {
    // Listen to session events
    ref.listen(sessionManagerProvider, (previous, next) {
      next.events.listen((event) {
        if (event == SessionEvent.sessionExpired ||
            event == SessionEvent.sessionEnded) {
          logout();
        }
      });
    });

    // Listen to FCM token refresh events
    ref.listen(fcmServiceProvider, (previous, fcmService) {
      fcmService.onTokenRefresh.listen((newToken) {
        if (newToken != null && state.value != null) {
          // Only update if user is logged in
          updateAppToken(newToken);
        }
      });
    });

    _loadToken();
    return const AsyncLoading(); // Start as loading until token validation is ready
  }

  Future<void> _loadToken() async {
    final localDataSource = ref.read(authLocalDataSourceProvider);
    final token = await localDataSource.getToken();
    if (token != null) {
      final getProfile = ref.read(getProfileUseCaseProvider);
      final result = await getProfile(NoParams());

      switch (result) {
        case Success(data: final user):
          ref.read(sessionManagerProvider).startSession();
          state = AsyncData(user);
          initializeFcmAndUpdateToken();
        case Failure():
          await logout(); // Token invalid or expired
      }
    } else {
      state = const AsyncData(null); // Unauthenticated
    }
  }

  void setUser(User user) {
    ref.read(sessionManagerProvider).startSession();
    state = AsyncData(user);
    initializeFcmAndUpdateToken();
  }

  Future<void> logout() async {
    ref.read(sessionManagerProvider).endSession();
    // Tokens are already cleared by the repository layer.
    // Just reset the in-memory auth state.
    state = const AsyncData(null);
  }

  /// Updates the FCM app token on the server.
  /// Call this when the token changes or on app startup.
  Future<void> updateAppToken(String appToken) async {
    if (appToken.isEmpty) return;

    final updateUseCase = ref.read(updateAppTokenUseCaseProvider);
    final result = await updateUseCase(appToken);

    switch (result) {
      case Success():
        // Token updated successfully
        break;
      case Failure():
        // Log error but don't throw - token update is not critical for app functionality
        ref.read(fcmServiceProvider);
    }
  }

  /// Initializes FCM and updates the app token if user is logged in.
  /// Should be called after successful login or app startup.
  Future<void> initializeFcmAndUpdateToken() async {
    final fcmService = ref.read(fcmServiceProvider);

    // Request permission
    final granted = await fcmService.requestPermission();
    if (!granted) {
      return;
    }

    // Get token and update
    final token = await fcmService.getToken();
    if (token != null) {
      await updateAppToken(token);
    }
  }
}
