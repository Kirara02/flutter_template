import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/base/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'get_profile_usecase.g.dart';

@riverpod
GetProfileUseCase getProfileUseCase(Ref ref) {
  return GetProfileUseCase(ref.watch(authRepositoryProvider));
}

class GetProfileUseCase implements UseCase<User, NoParams> {
  final IAuthRepository _repository;

  GetProfileUseCase(this._repository);

  @override
  Future<Result<User>> call(NoParams params) async {
    return _repository.getProfile();
  }
}
