import 'package:flutter_test/flutter_test.dart';
import 'package:kirara_template/core/result/result.dart';
import 'package:kirara_template/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:kirara_template/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:kirara_template/features/auth/data/models/requests/login_request.dart';
import 'package:kirara_template/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kirara_template/features/auth/domain/entities/user.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}
class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  const testLoginRequest = LoginRequest(username: 'test', password: 'password');
  final testResponse = {
    'access_token': 'access',
    'refresh_token': 'refresh',
    'user': {
      'id': 1,
      'name': 'Test',
      'username': 'test',
      'role': 'User',
    }
  };

  group('AuthRepositoryImpl.login', () {
    test('should save tokens and return User on successful login', () async {
      // arrange
      when(() => mockRemoteDataSource.login(any()))
          .thenAnswer((_) async => Success(testResponse));
      when(() => mockLocalDataSource.saveToken(any())).thenAnswer((_) async => true);
      when(() => mockLocalDataSource.saveRefreshToken(any())).thenAnswer((_) async => true);

      // act
      final result = await repository.login(testLoginRequest);

      // assert
      expect(result, isA<Success<User>>());
      verify(() => mockLocalDataSource.saveToken('access')).called(1);
      verify(() => mockLocalDataSource.saveRefreshToken('refresh')).called(1);
    });

    test('should return Failure on remote datasource failure', () async {
      // arrange
      when(() => mockRemoteDataSource.login(any()))
          .thenAnswer((_) async => Failure(Exception('Failed')));

      // act
      final result = await repository.login(testLoginRequest);

      // assert
      expect(result, isA<Failure<User>>());
    });
  });
}
