extension NumberExtension on int {
  String format() {
    final List<int> limits = [1000, 100000, 1000000, 1000000000];

    if (this >= limits[0] && this < limits[1]) {
      return "${(this / limits[0]).toStringAsFixed(1)}K";
    }
    if (this >= limits[1] && this < limits[2]) {
      return "${(this / limits[0]).toStringAsFixed(0)}K";
    }
    if (this >= limits[2] && this < limits[3]) {
      return "${(this / limits[2]).toStringAsFixed(1)}M";
    }
    if (this >= limits[3]) {
      return "${(this / limits[3]).toStringAsFixed(1)}B";
    }

    return toString();
  }
}
