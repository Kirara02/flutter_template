import 'package:flutter_test/flutter_test.dart';
import 'package:kirara_template/features/auth/domain/entities/user.dart';

void main() {
  group('User Entity', () {
    test('should create a valid User entity', () {
      const user = User(
        id: 1,
        name: 'John Doe',
        username: 'johndoe',
        role: 'admin',
      );

      expect(user.id, 1);
      expect(user.name, 'John Doe');
      expect(user.username, 'johndoe');
      expect(user.role, 'admin');
    });

    test('should support value equality', () {
      const user1 = User(
        id: 1,
        name: 'John Doe',
        username: 'johndoe',
        role: 'admin',
      );
      const user2 = User(
        id: 1,
        name: 'John Doe',
        username: 'johndoe',
        role: 'admin',
      );

      expect(user1, equals(user2));
    });
  });
}
