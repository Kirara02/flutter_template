import '../../../../core/base/result.dart';
import '../entities/user.dart';
import '../../data/models/requests/login_request.dart';

abstract class IAuthRepository {
  Future<Result<User>> login(LoginRequest request);
  Future<Result<User>> getProfile();
  Future<Result<void>> logout();
}
