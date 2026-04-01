import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/safe_api_call.dart';
import '../../../../core/base/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_datasource.g.dart';

abstract class AuthRemoteDataSource {
  Future<Result<Map<String, dynamic>>> login(Map<String, dynamic> requestData);

  Future<Result<Map<String, dynamic>>> getProfile();

  Future<Result<Map<String, dynamic>>> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<Result<Map<String, dynamic>>> login(Map<String, dynamic> requestData) async {
    return safeApiCall(
      () => _dio.post('/api/auth/login', data: requestData),
      mapper: (data) => data,
    );
  }

  @override
  Future<Result<Map<String, dynamic>>> getProfile() async {
    return safeApiCall(() => _dio.get('/api/auth/profile'), mapper: (data) => data);
  }

  @override
  Future<Result<Map<String, dynamic>>> logout() async {
    return safeApiCall(() => _dio.post('/api/auth/logout'), mapper: (data) => data ?? {});
  }
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(ref.watch(dioProvider));
}
