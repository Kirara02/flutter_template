class LoginRequest {
  final String identity;
  final String password;

  const LoginRequest({required this.identity, required this.password});

  Map<String, dynamic> toMap() {
    return {'identity': identity, 'password': password};
  }
}
