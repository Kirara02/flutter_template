import '../../../../core/base/result.dart';
import '../entities/user.dart';
import '../../data/models/requests/login_request.dart';
import '../../data/models/requests/change_password_request.dart';

abstract class IAuthRepository {
  Future<Result<User>> login(LoginRequest request);
  Future<Result<User>> signInWithGoogle(String idToken);
  Future<Result<User>> getProfile();
  Future<Result<void>> logout();
  Future<Result<void>> changePassword(ChangePasswordRequest request);
  Future<Result<void>> updateAppToken(String appToken);
}
