import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kirara_template/core/localization/strings.g.dart';
import 'package:kirara_template/core/widgets/app_button.dart';
import 'package:kirara_template/core/widgets/app_text_field.dart';
import 'package:kirara_template/features/auth/presentation/screens/login/login_screen.dart';

void main() {
  Widget createWidgetUnderTest() {
    return TranslationProvider(
      child: const ProviderScope(
        child: MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('should display login form elements', (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // assert
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(AppTextField), findsNWidgets(2));
      expect(find.byType(AppButton), findsOneWidget);
      
      // Verify text from localization
      expect(find.text(t.login.title), findsOneWidget);
    });

    testWidgets('should show error when fields are empty and login is pressed', (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // act
      final loginButton = find.byType(AppButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // assert
      expect(find.text(t.login.errorEmpty), findsNWidgets(2));
    });
  });
}
