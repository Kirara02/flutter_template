class ChangePasswordRequest {
  final String? oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordRequest({
    this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      if (oldPassword != null) 'old_password': oldPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
  }
}
