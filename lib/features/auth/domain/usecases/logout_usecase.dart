import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:kirara_template/core/result/result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'logout_usecase.g.dart';

@riverpod
LogoutUseCase logoutUseCase(Ref ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
}

class LogoutUseCase {
  final IAuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Result<void>> call() async {
    return _repository.logout();
  }
}
