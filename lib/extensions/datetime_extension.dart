extension DateTimeExtension on DateTime {
  String get toViewFormat =>
      "${day.toString().padLeft(2, "0")}.${month.toString().padLeft(2, "0")}.$year";
}

extension StringExtension on String {
  DateTime get toDateTimeFormat {
    List<String> fields = split(".");
    return DateTime.parse("${fields[2]}-${fields[1]}-${fields[0]}");
  }
}
