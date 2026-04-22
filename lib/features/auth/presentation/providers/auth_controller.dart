import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/result.dart';
import '../../../../core/base/use_case.dart';
import '../../../../core/logger/logger_provider.dart';
import '../../data/models/requests/login_request.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/google_sign_in_use_case.dart';
import 'auth_provider.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> login(String identity, String password) async {
    // Set state to loading
    state = const AsyncValue.loading();

    final useCase = ref.read(loginUseCaseProvider);
    final authNotifier = ref.read(authProvider.notifier);

    // Execute the usecase inside a try-catch to properly update AsyncValue state
    state = await AsyncValue.guard(() async {
      final request = LoginRequest(identity: identity, password: password);
      final result = await useCase(request);

      switch (result) {
        case Success(data: final user, :final message):
          authNotifier.setUser(user);
          return message;
        case Failure(:final error):
          throw error;
      }
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(googleSignInUseCaseProvider);
    final authNotifier = ref.read(authProvider.notifier);

    state = await AsyncValue.guard(() async {
      final logger = ref.read(loggerProvider);
      try {
        logger.i('Starting Google Sign-In process...');
        final googleSignIn = GoogleSignIn.instance;
        final clientId = dotenv.env['GOOGLE_CLIENT_ID'];
        final serverClientId = dotenv.env['GOOGLE_SERVER_CLIENT_ID'];

        await googleSignIn.initialize(
          clientId: (clientId?.isEmpty ?? true) ? null : clientId,
          serverClientId: (serverClientId?.isEmpty ?? true)
              ? null
              : serverClientId,
        );

        final account = await googleSignIn.authenticate(
          scopeHint: ['email', 'profile', 'openid'],
        );
        logger.d('Google Account: ${account.email}');

        final auth = account.authentication;
        final idToken = auth.idToken;

        if (idToken == null) {
          logger.e('Could not get ID Token from Google');
          throw 'Could not get ID Token from Google';
        }

        logger.d('Obtained ID Token, calling backend...');
        final result = await useCase.execute(idToken);

        switch (result) {
          case Success(data: final user, :final message):
            logger.i('Google Sign-In successful for user: ${user.username}');
            authNotifier.setUser(user);
            return message;
          case Failure(:final error):
            logger.e('Google Sign-In backend failure: $error');
            ref.read(loggerProvider).e(error);
            throw error;
        }
      } catch (e) {
        logger.e('Google Sign-In unexpected error: $e');
        rethrow;
      }
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(logoutUseCaseProvider);
    final authNotifier = ref.read(authProvider.notifier);

    state = await AsyncValue.guard(() async {
      final result = await useCase(NoParams());

      switch (result) {
        case Success(:final message):
          await authNotifier.logout(); // Clear global state
          return message;
        case Failure(:final error):
          throw error;
      }
    });
  }
}
