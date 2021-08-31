import 'dart:convert';
import "package:flutter/foundation.dart";

enum UserRole { Volunteer, Admin, Visitor }

class User with ChangeNotifier {
  String _name;
  String _email;
  // String _lastLogin;
  String? _memberSinceDate;
  String? _phoneNumber;
  String _id;
  String _role;
  int _score;
  List<dynamic>? events;
  // ignore: non_constant_identifier_names
  final String? BITS_ID;
  User(
      {required String id,
      required String email,
      required String name,
      required String role,
      required String memberSinceDate,
      String? phoneNumber,
      String? BITS_ID,
      required List<dynamic> events,
      // required String lastLogin,
      required int score})
      : this._id = id,
        this._email = email,
        this._name = name,
        this._role = role,
        // this._lastLogin = lastLogin,
        this.BITS_ID = BITS_ID,
        this._memberSinceDate = memberSinceDate,
        this._score = score,
        this.events = events,
        this._phoneNumber = phoneNumber;

  factory User.anonymousUser() {
    return User(
        id: "id",
        email: "email",
        name: "Guest",
        role: "Guest",
        events: [],
        score: 0,
        memberSinceDate: "memberSinceDate");
  }

  /// The user Id as in the database
  String get id => _id;

  /// The BITS ID string
  // ignore: non_constant_identifier_names
  String get BitsId => BITS_ID ?? "2020QWE1234H";

  String get name => _name;
  String get memberSinceDate => _memberSinceDate ?? "1 Jan 2020";
  String get score => _score.toString();
  // String get lastLogin => _lastLogin;

  // set lastLogin(String lastLogin) => _lastLogin = lastLogin;
  /// Name as provided by database call
  String get email => _email;

  /// UserRole for displaying in UI
  String get roleString => _role;

  String get phoneNumber => _phoneNumber ?? "No number provided";

  /// UserRole to use in managing role based views
  UserRole get role {
    switch (this.roleString) {
      case "Volunteer":
        return UserRole.Volunteer;
      default:
        return UserRole.Admin;
    }
  }

  // set email(String email) => _email = email;
  factory User.fromJson(Map<String, dynamic> json) {
    print(jsonEncode(json["user"]?["events"]));
    if (json['user'] == null)
      return User(
        id: json["_id"],
        email: json['email'],
        name: json['name'],
        phoneNumber: json["phoneNumber"],
        memberSinceDate: json['memberSinceDate'] ?? "2020",
        role: json['role'] ?? "Volunteer",
        BITS_ID: json["BITS_ID"] ?? "2020QWE1234H",
        events: json["events"] ?? [],
        score: json["events"] ?? 10,
      );
    else
      return User(
        id: json['user']["_id"],
        email: json['user']['email'],
        name: json['user']['name'],
        phoneNumber: json['user']["phoneNumber"],
        memberSinceDate: json['user']['memberSinceDate'] ?? "2020",
        role: json['user']['role'] ?? "Volunteer",
        BITS_ID: json['user']["BITS_ID"] ?? "2020QWE1234H",
        events: (json['user']?["events"] ?? []),
        score: json["user"]?["score"] ?? 0,
      );
  }
  Map<String, dynamic> toJson() => {
        "_id": _id,
        "name": _name,
        "email": email,
        "role": _role,
        "phoneNumber": _phoneNumber,
        "score": _score,
        "BITS_ID": BITS_ID,
      };
  //  {
  //   _userId = json['userId'];
  //   _username = json['username'];
  //   _name = json['name'];
  //   _lastLogin = json['lastLogin'];
  //   _email = json['email'];
  // }
}
