// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));
EventModel eventModelGetFromJson(Map<String, dynamic> str) =>
    EventModel.fromJson(str);

String eventModelToJson(EventModel data) => json.encode(data.toJson());

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
    required this.noOfVolunteers,
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
  final int noOfVolunteers;
  final int v;
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
        organiser: json["organiser"],
        noOfVolunteers: json["noOfVolunteers"],
        v: json["__v"],
        eventModelId: json["id"],
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
        "__v": v,
        "id": eventModelId,
      };
}
