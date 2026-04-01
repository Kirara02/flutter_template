import '../../../../core/utils/map_serializable.dart';

import '../../domain/entities/user.dart';

class UserDto extends MapSerializable {
  const UserDto.fromMap(super.data) : super.fromMap();

  int get id => this['id'] as int;

  String get name => this['name'] as String;

  String get username => this['username'] as String;

  String get role => this['role'] as String;

  User toDomain() {
    return User(id: id, name: name, username: username, role: role);
  }
}
