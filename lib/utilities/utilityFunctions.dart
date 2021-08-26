extension EventModelString on String {
  bool isBeforeRightNow() {
    final other = DateTime.now(); // DateTime.parse("$otherDate 00:00:00Z");
    final thisDate = this.toDateTime();
    return thisDate.isBefore(other);
  }

  DateTime toDateTime() {
    print(this);
    try {
      String regexString = r'(\d+)\/(\d+)\/(\d{2,})';
      RegExp regExp = new RegExp(regexString);
      var matches = regExp.allMatches(this);

      var match = matches.elementAt(0);
      return DateTime.parse(
          "${match.group(3)}-${match.group(2)?.padLeft(2, "0")}-${match.group(1)} 00:00:00Z");
    } catch (e) {
      print("Asdasd");
      String regexString = r'(\d+):(\d+):(\d+)';
      RegExp regExp = new RegExp(regexString);
      var matches = regExp.allMatches(this);

      var match = matches.elementAt(0);
      final time =
          "${match.group(1)?.padLeft(2, "0")}:${match.group(2)?.padLeft(2, "0")}:${match.group(3)?.padLeft(2, "0")}";
      final today = DateTime.now();
      return DateTime.parse(
          "${today.year}-${today.hour.toString().padLeft(2, "0")}-${today.day} ${time}Z");
    }
  }
}
