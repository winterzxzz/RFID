class TimeUtils {
  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    // 20s ago, 1m ago, 2h ago, 3d ago
    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }

  static String getDiffDays(DateTime optimalTime) {
    final now = DateTime.now();
    // round to 1 decimal place
    return (optimalTime.difference(now).inMilliseconds / (1000 * 60 * 60 * 24))
        .toStringAsFixed(2);
  }
}
