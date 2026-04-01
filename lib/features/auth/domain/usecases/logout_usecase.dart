import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/base/use_case.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'logout_usecase.g.dart';

@riverpod
LogoutUseCase logoutUseCase(Ref ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
}

class LogoutUseCase implements UseCase<void, NoParams> {
  final IAuthRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Result<void>> call(NoParams params) async {
    return _repository.logout();
  }
}
