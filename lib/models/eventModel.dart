// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:nssapp/services/api.dart';
import 'package:nssapp/utilities/utilityFunctions.dart';
import 'package:provider/provider.dart';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));
EventModel eventModelGetFromJson(Map<String, dynamic> str) =>
    EventModel.fromJson(str);

String eventModelToJson(EventModel data) => json.encode(data.toJson());
const List<String> d = [];

class EventModel with ChangeNotifier {
  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.withDrawTime,
    required this.location,
    required this.description,
    required this.organiser,
    this.users = d,
    this.closed = false,
    required this.noOfVolunteers,
    required this.score,
    required this.v,
    required this.eventModelId,
  });

  String id;
  String title;
  String date;
  String startTime;
  String endTime;
  String withDrawTime;
  String location;
  String description;
  String organiser;
  List<dynamic> users;
  List<Map<String, dynamic>>? usersWithNames;
  bool closed;
  int noOfVolunteers;
  int v;
  int score;
  String eventModelId;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["_id"],
        title: json["title"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        withDrawTime: json["withDrawTime"],
        location: json["location"],
        description: json["description"],
        organiser: json["organiser"] ?? "NSS",
        users: json["users"],
        noOfVolunteers: int.tryParse('${json["noOfVolunteers"]}') ?? 30,
        score: int.parse(json["score"]?.toString() ?? "10"),
        v: json["__v"] ?? 0,
        eventModelId: json["id"] ?? "",
        closed: (json["closed"]?.toString().toLowerCase() == "true"),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "withDrawTime": withDrawTime,
        "location": location,
        "description": description,
        "organiser": organiser,
        "noOfVolunteers": noOfVolunteers,
        "score": score,
        "users": users,
        "__v": v,
        "id": eventModelId,
        "closed": closed,
      };

  /// If the event `date` is in the future
  bool get isInTheFuture {
    // This date must be today or after today
    // If the date is today, the startTime must also
    // be after now.
    return this.date.isAfterRightNow(isTime: false) &&
        this.startTime.isAfterRightNow(isTime: true);
  }
  // bool get isInTheFuture {
  /// This implementation only does half the job
  /// by only checking
  //   String dateForParsing = "";

  //   // this.date is of the format : DD/MM/YYYY
  //   // DateTime.parse takes in input of the format : YYYY-MM-DD

  //   // Conversion from DD/MM/YYYY to YYYY-MM-DD
  //   dateForParsing += this.date.substring(6, this.date.length);
  //   dateForParsing += '-';
  //   dateForParsing += this.date[3] + this.date[4];
  //   dateForParsing += '-';
  //   dateForParsing += this.date[0] + this.date[1];

  //   return DateTime.parse(dateForParsing).isAfter(DateTime.now());
  // }

  // bool get isInTheFuture =>
  //     (!this.date.isBeforeRightNow(isTime: false) && !this.startTime.isBeforeRightNow(isTime: true));

  /// Checks if user is in the `users` array
  bool hasRegistered(String userID) => this.users.contains(userID);

  /// True if withdrawal time has not passed
  bool get canWithdraw =>
      this.withDrawTime.toDateTime(isTime: true).isAfter(DateTime.now());

  void updateThisWith(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    date = json["date"];
    startTime = json["startTime"];
    endTime = json["endTime"];
    withDrawTime = json["withDrawTime"];
    location = json["location"];
    description = json["description"];
    organiser = json["organiser"] ?? "NSS";
    users = json["users"];
    noOfVolunteers = int.tryParse('${json["noOfVolunteers"]}') ?? 30;
    score = int.parse(json["score"]?.toString() ?? "10");
    v = json["__v"] ?? 0;
    eventModelId = json["id"] ?? "";
  }

  Future<void> updateThisWithUserDetails() async {
    final data = await getOneEvent(this.id);
    if (data == null) return;
    final jsonData = json.decode(data);
    try {
      this.usersWithNames = [...jsonData["users"]];
      this.closed = jsonData["closed"] ?? closed;
    } on Exception catch (e) {
      this.usersWithNames = null;
    }
  }

  Future<bool> get canBeRegisteredFor async {
    final users = await getEventUsers(this.id);
    this.users = users ?? [];
    notifyListeners();
    return ((users?.length ?? 0) < noOfVolunteers);
  }
}
