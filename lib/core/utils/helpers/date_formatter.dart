class DateFormatter {
  DateFormatter._();

  /// ISO8601 문자열 → "방금 전", "N분 전", "N시간 전", "N일 전", "N주 전", "N개월 전", "N년 전"
  static String timeAgo(String isoString) {
    if (isoString.isEmpty) return '';

    final DateTime? parsed = DateTime.tryParse(isoString);
    if (parsed == null) return isoString;

    final now = DateTime.now();
    final diff = now.difference(parsed.toLocal());

    if (diff.inSeconds < 60) return '방금 전';
    if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
    if (diff.inHours < 24) return '${diff.inHours}시간 전';
    if (diff.inDays < 7) return '${diff.inDays}일 전';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}주 전';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}개월 전';
    return '${(diff.inDays / 365).floor()}년 전';
  }
}
