import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:kirara_template/core/result/result.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/entities/user.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AsyncValue<User?> build() {
    _loadToken();
    return const AsyncLoading(); // Start as loading until token validation is ready
  }

  Future<void> _loadToken() async {
    final localDataSource = ref.read(authLocalDataSourceProvider);
    final token = await localDataSource.getToken();
    if (token != null) {
      final getProfile = ref.read(getProfileUseCaseProvider);
      final result = await getProfile();

      switch (result) {
        case Success(data: final user):
          state = AsyncData(user);
        case Failure():
          await logout(); // Token invalid or expired
      }
    } else {
      state = const AsyncData(null); // Unauthenticated
    }
  }

  void setUser(User user) {
    state = AsyncData(user);
  }

  Future<void> logout() async {
    // Tokens are already cleared by the repository layer.
    // Just reset the in-memory auth state.
    state = const AsyncData(null);
  }
}
