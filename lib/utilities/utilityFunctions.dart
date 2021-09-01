import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

extension EventModelString on String {
  bool isBeforeRightNow() {
    final now = DateTime.now(); // DateTime.parse("$otherDate 00:00:00Z");

    final other = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 1));
    final thisDate = this.toDateTime();
    return thisDate.isBefore(other);
  }

  DateTime toDateTime() {
    // print(this);
    try {
      String regexString = r'(\d+)\/(\d+)\/(\d{2,})';
      RegExp regExp = new RegExp(regexString);
      var matches = regExp.allMatches(this);

      var match = matches.elementAt(0);
      final d =
          "${match.group(3)?.padLeft(2, "0")}-${match.group(2)?.padLeft(2, "0")}-${match.group(1)?.padLeft(2, "0")} 00:00:00Z";
      // print(d);
      return DateTime.parse(d);
    } catch (e) {
      // print("Asdasd");
      String regexString = r'(\d+):(\d+):?(\d{0,2})';
      RegExp regExp = new RegExp(regexString);
      var matches = regExp.allMatches(this);

      var match = matches.elementAt(0);
      // print(match.groupCount);

      late final String thirdMatch;
      try {
        thirdMatch = match.group(3)?.padLeft(2, "0") ?? "00";
      } catch (e) {
        thirdMatch = "00";
      }
      final time =
          "${match.group(1)?.padLeft(2, "0")}:${match.group(2)?.padLeft(2, "0")}:$thirdMatch";
      final today = DateTime.now();
      return DateTime.parse(
          "${today.year}-${today.hour.toString().padLeft(2, "0")}-${today.day.toString().padLeft(2, "0")} ${time}Z");
    }
  }
}

void launchUrl(String url, {BuildContext? context}) {
  try {
    launch(url);
  } catch (e) {
    if (context != null)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Could not open URL")));
  }
}
