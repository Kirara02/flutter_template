import '../../../../core/base/result.dart';
import '../../../../core/base/use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/requests/login_request.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

part 'login_usecase.g.dart';

@riverpod
LoginUseCase loginUseCase(Ref ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
}

class LoginUseCase implements UseCase<User, LoginRequest> {
  final IAuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Result<User>> call(LoginRequest request) {
    if (request.username.isEmpty || request.password.isEmpty) {
      return Future.value(Result.failure(Exception('Email and password must not be empty')));
    }

    return _repository.login(request);
  }
}
