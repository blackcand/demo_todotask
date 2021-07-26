String formatTime(DateTime time) {
  String addMonth = time.month < 10 ? "0" : "";
  String addDay = time.day < 10 ? "0" : "";
  String date = "${time.year}-$addMonth${time.month}-$addDay${time.day}";
  return date;
}
