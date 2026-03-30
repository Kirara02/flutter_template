import 'package:intl/intl.dart';

/// Extension methods for DateTime operations
extension DateTimeExt on DateTime? {
  String format([String pattern = 'dd MMM yyyy']) {
    if (this == null) return '';
    return DateFormat(pattern).format(this!);
  }

  String get timeAgo {
    if (this == null) return '';
    final now = DateTime.now();
    final difference = now.difference(this!);

    if (difference.inDays > 7) return format();
    if (difference.inDays >= 1) return '${difference.inDays} days ago';
    if (difference.inHours >= 1) return '${difference.inHours} hours ago';
    if (difference.inMinutes >= 1) return '${difference.inMinutes} minutes ago';
    return 'Just now';
  }
}
