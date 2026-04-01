import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/base/use_case.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../../../core/auth/session_manager.dart';
import '../../domain/entities/user.dart';

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
  }

  Future<void> logout() async {
    ref.read(sessionManagerProvider).endSession();
    // Tokens are already cleared by the repository layer.
    // Just reset the in-memory auth state.
    state = const AsyncData(null);
  }
}
