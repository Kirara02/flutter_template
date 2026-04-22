import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/base/result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'google_sign_in_use_case.g.dart';

@riverpod
GoogleSignInUseCase googleSignInUseCase(Ref ref) {
  return GoogleSignInUseCase(ref.watch(authRepositoryProvider));
}

class GoogleSignInUseCase {
  final IAuthRepository _repository;

  GoogleSignInUseCase(this._repository);

  Future<Result<User>> execute(String idToken) {
    return _repository.signInWithGoogle(idToken);
  }
}
