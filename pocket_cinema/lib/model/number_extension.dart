extension NumberExtension on int {
  String format() {
    if (this > 999 && this < 99999) {
      return "${(this / 1000).toStringAsFixed(1)}K";
    }
    if (this > 99999 && this < 999999) {
      return "${(this / 1000).toStringAsFixed(0)}K";
    }
    if (this > 999999 && this < 999999999) {
      return "${(this / 1000000).toStringAsFixed(1)}M";
    }
    if (this > 999999999) {
      return "${(this / 1000000000).toStringAsFixed(1)}B";
    }

    return toString();
  }
}
