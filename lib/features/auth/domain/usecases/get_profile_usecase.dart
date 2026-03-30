import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:kirara_template/core/result/result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'get_profile_usecase.g.dart';

@riverpod
GetProfileUseCase getProfileUseCase(Ref ref) {
  return GetProfileUseCase(ref.watch(authRepositoryProvider));
}

class GetProfileUseCase {
  final IAuthRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Result<User>> call() async {
    return _repository.getProfile();
  }
}
