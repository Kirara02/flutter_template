import '../../../../core/base/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/requests/change_password_request.dart';
import '../../domain/usecases/change_password_usecase.dart';

part 'change_password_controller.g.dart';

@riverpod
class ChangePasswordController extends _$ChangePasswordController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> changePassword({
    String? oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(changePasswordUseCaseProvider);

    state = await AsyncValue.guard(() async {
      final request = ChangePasswordRequest(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      final result = await useCase(request);

      switch (result) {
        case Success(:final message):
          return message;
        case Failure(:final error):
          throw error;
      }
    });
  }
}
