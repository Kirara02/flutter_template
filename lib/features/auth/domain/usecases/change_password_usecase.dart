import '../../../../core/base/result.dart';
import '../../../../core/base/use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/requests/change_password_request.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';
import '../../presentation/providers/auth_provider.dart';

part 'change_password_usecase.g.dart';

@riverpod
ChangePasswordUseCase changePasswordUseCase(Ref ref) {
  final user = ref.watch(authProvider).value;
  return ChangePasswordUseCase(
    ref.watch(authRepositoryProvider),
    hasPassword: user?.hasPassword ?? true,
  );
}

class ChangePasswordUseCase implements UseCase<void, ChangePasswordRequest> {
  final IAuthRepository _repository;
  final bool hasPassword;

  ChangePasswordUseCase(this._repository, {required this.hasPassword});

  @override
  Future<Result<void>> call(ChangePasswordRequest request) {
    final oldPassword = request.oldPassword;
    if ((hasPassword && (oldPassword == null || oldPassword.isEmpty)) ||
        request.newPassword.isEmpty ||
        request.confirmPassword.isEmpty) {
      return Future.value(
        Result.failure(Exception('All fields must not be empty')),
      );
    }

    if (request.newPassword != request.confirmPassword) {
      return Future.value(
        Result.failure(Exception('New passwords do not match')),
      );
    }

    return _repository.changePassword(request);
  }
}
