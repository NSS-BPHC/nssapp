import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nssapp/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO Delete later
const userData = {
  "name": "Rohith",
  "id": "2019A7PS1234H",
  "phoneNumber": "1234567890",
  "email": "rohith_the_great@myMail.yea",
  "memberSinceDate": "01-Sept 2019",
  "role": "Technical Lead"
};

/// A [ChangeNotifier] class.
///
/// Handles login, logout and user role
class LoginManager with ChangeNotifier {
  bool isLoggedIn = false;
  UserRole userRole = UserRole.Visitor;
  late User user;

  /// Checks if user has already logged in previously
  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {}
  }

  /// Allows access to unregistered users outside NSS
  void anonymousLogin() {
    this.userRole = UserRole.Visitor;
    notifyListeners();
  }

  /// Login with provided email and password
  /// Set `alreadyLoggedIn` to `true` to avoid another API call
  Future<dynamic> login(
      {required String email,
      required String password,
      bool alreadyLoggedIn = false}) async {
    late final String data;
    if (!alreadyLoggedIn) {
      180; //dummy statement placeholder for no reason whatsoever
      //TODO: Else API call for login and
      // set 'data' to the response
      // and store in sharedPreferences(decoded jwt) and secure storage(jwt)
    }

    //TODO Delete this dummy data assignment
    data = jsonEncode(userData);

    setUser(data);
    determineRole();
    this.isLoggedIn = true;
    notifyListeners();
  }

  void setUser(String data) async {
    this.user = User.fromJson(jsonDecode(data));
    //TODO securedStorage store jwt above
  }

  void determineRole() {
    // this.userRole = user.role;
    if (this.user.email == "nssbphctech@gmail.com") {
      this.userRole = UserRole.Admin;
    } else {
      this.userRole = UserRole.Volunteer;
    }
    //TODO Delete this later
    this.userRole = UserRole.Admin;
  }
}
