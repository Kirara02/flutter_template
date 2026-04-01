/// Extension methods for String operations
extension StringExt on String {
  String get capitalize =>
      isNotEmpty ? "${this[0].toUpperCase()}${substring(1)}" : this;

  bool get isEmail {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(this);
  }

  /// Returns true if the string is a valid HTTP/HTTPS URL.
  bool get isUrl => RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}'
    r'\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$',
  ).hasMatch(this);

  /// Truncates to [maxLength] characters, appending [ellipsis] if trimmed.
  String truncate(int maxLength, {String ellipsis = '...'}) =>
      length <= maxLength ? this : '${substring(0, maxLength)}$ellipsis';
}

/// Extension methods for String nullable operations
extension NullableStringExt on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Helper to provide a default value if string is null or empty
  String orDefault(String defaultValue) {
    return isNullOrEmpty ? defaultValue : this!;
  }
}
