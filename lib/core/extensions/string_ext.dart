/// Extension methods for String operations
extension StringExt on String {
  String get capitalize =>
      isNotEmpty ? "${this[0].toUpperCase()}${substring(1)}" : this;

  bool get isValidEmail {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(this);
  }
}

/// Extension methods for String nullable operations
extension NullableStringExt on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  String get capitalize => this?.capitalize ?? "";

  bool get isValidEmail => this?.isValidEmail ?? false;

  /// Helper to provide a default value if string is null or empty
  String orDefault(String defaultValue) {
    return isNullOrEmpty ? defaultValue : this!;
  }
}
