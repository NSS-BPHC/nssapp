// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';
import 'package:nssapp/services/api.dart';
import 'package:nssapp/utilities/utilityFunctions.dart';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));
EventModel eventModelGetFromJson(Map<String, dynamic> str) =>
    EventModel.fromJson(str);

String eventModelToJson(EventModel data) => json.encode(data.toJson());
const List<String> d = [];

class EventModel {
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
    required this.noOfVolunteers,
    required this.score,
    required this.v,
    required this.eventModelId,
  });

  final String id;
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final String withDrawTime;
  final String location;
  final String description;
  final String organiser;
  final List<dynamic> users;
  final int noOfVolunteers;
  final int v;
  final int score;
  final String eventModelId;

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
      };
  bool get isInTheFuture => !this.date.isBeforeRightNow();

  bool hasRegistered(String userID) => this.users.contains(userID);

  bool get canWithdraw =>
      this.withDrawTime.toDateTime().isAfter(DateTime.now());

  Future<bool> get canBeRegisteredFor async {
    final users = await getEventUsers(this.id);
    return ((users?.length ?? 0) < noOfVolunteers);
  }
}
