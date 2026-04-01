import '../../../../core/base/result.dart';
import '../../../../core/base/use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/requests/login_request.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_provider.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> login(String username, String password) async {
    // Set state to loading
    state = const AsyncValue.loading();

    final useCase = ref.read(loginUseCaseProvider);
    final authNotifier = ref.read(authProvider.notifier);

    // Execute the usecase inside a try-catch to properly update AsyncValue state
    state = await AsyncValue.guard(() async {
      final request = LoginRequest(username: username, password: password);
      final result = await useCase(request);

      switch (result) {
        case Success(data: final user, :final message):
          authNotifier.setUser(user);
          return message;
        case Failure(:final error):
          throw error;
      }
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(logoutUseCaseProvider);
    final authNotifier = ref.read(authProvider.notifier);

    state = await AsyncValue.guard(() async {
      final result = await useCase(NoParams());

      switch (result) {
        case Success(:final message):
          await authNotifier.logout(); // Clear global state
          return message;
        case Failure(:final error):
          throw error;
      }
    });
  }
}
