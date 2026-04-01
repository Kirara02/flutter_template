import 'package:flutter_test/flutter_test.dart';
import 'package:kirara_template/core/base/result.dart';
import 'package:kirara_template/features/auth/data/models/requests/login_request.dart';
import 'package:kirara_template/features/auth/domain/entities/user.dart';
import 'package:kirara_template/features/auth/domain/repositories/auth_repository.dart';
import 'package:kirara_template/features/auth/domain/usecases/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  const testRequest = LoginRequest(username: 'test', password: 'password');
  const testUser = User(id: 1, name: 'Test', username: 'test', role: 'User');

  test('should return Success when repository login status is success', () async {
    // arrange
    when(() => mockRepository.login(any()))
        .thenAnswer((_) async => const Success(testUser));

    // act
    final result = await useCase(testRequest);

    // assert
    expect(result, isA<Success<User>>());
    final successResult = result as Success<User>;
    expect(successResult.data, testUser);
    verify(() => mockRepository.login(testRequest)).called(1);
  });

  test('should return Failure when username is empty', () async {
    // arrange
    const emptyRequest = LoginRequest(username: '', password: 'password');

    // act
    final result = await useCase(emptyRequest);

    // assert
    expect(result, isA<Failure<User>>());
    verifyNever(() => mockRepository.login(any()));
  });

  setUpAll(() {
    registerFallbackValue(testRequest);
  });
}
