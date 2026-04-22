import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/base/use_case.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'update_app_token_usecase.g.dart';

@riverpod
UpdateAppTokenUseCase updateAppTokenUseCase(Ref ref) {
  return UpdateAppTokenUseCase(ref.watch(authRepositoryProvider));
}

class UpdateAppTokenUseCase implements UseCase<void, String> {
  final IAuthRepository _repository;

  UpdateAppTokenUseCase(this._repository);

  @override
  Future<Result<void>> call(String appToken) async {
    return _repository.updateAppToken(appToken);
  }
}
