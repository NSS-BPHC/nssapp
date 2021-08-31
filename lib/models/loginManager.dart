import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nssapp/models/userModel.dart';
import 'package:nssapp/services/api.dart' as api;
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
  bool failedLogIn = false;
  bool isLoading = false;
  String? jwt;
  String error = "";
  UserRole userRole = UserRole.Visitor;
  late User user;

  bool get isAdmin => this.userRole == UserRole.Admin;
  bool get isVisitor => this.userRole == UserRole.Visitor;

  /// Checks if user has already logged in previously
  /// Loads the user data in `user`
  Future<void> init({bool hardRefresh = false}) async {
    print("init");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!hardRefresh && prefs.containsKey('user')) {
      this.setUser(prefs.getString('user'));
      this.isLoggedIn = true;
      notifyListeners();
      final storage = new FlutterSecureStorage();
      this.jwt = await storage.read(key: 'jwt');

      determineRole(this.jwt ?? "as", notify: true);
      return;
    }
    final storage = new FlutterSecureStorage();
    final jwt = await storage.read(key: 'jwt');
    if (jwt != null) {
      // print("jwt exists");

      final userData =
          await api.getAndStoreUserData(jwt: jwt, forceNewFetch: hardRefresh);
      // print("userData");
      // print(userData);
      this.setUser(userData);
      successfulLogin();
    }
  }

  /// Allows access to unregistered users outside NSS
  void anonymousLogin() {
    this.userRole = UserRole.Visitor;
    this.user = User.anonymousUser();
    this.isLoggedIn = true;
    notifyListeners();
  }

  /// Login with provided email and password
  /// Set `alreadyLoggedIn` to `true` to avoid another API call
  Future<bool> login(
      {required String email,
      required String password,
      bool alreadyLoggedIn = false}) async {
    this.isLoading = true;
    notifyListeners();
    late final String? data;
    if (!alreadyLoggedIn) {
      print("logging in manager");
      final api.ApiResponse response =
          await api.login(email: email, password: password);
      // data =
      print("apiError=${response.apiError}");
      if (response.apiError != null) {
        // this.failedLogIn = true;
        // this.error = response.apiError ?? "Login failed";
        // notifyListeners();
        this.loginFailed(response.apiError ?? "Login failed");
        return false;
      }
      data = response.data;
      this.init();
    }
    determineRole(data ?? "sa");
    return true;
  }

  /// Set userModel
  void setUser(String? data) {
    if (data != null) this.user = User.fromJson(jsonDecode(data));
  }

  /// Set the current user's role
  /// using JWT `data`
  void determineRole(String data, {bool notify = false}) {
    try {
      final d = JwtDecoder.decode(data);
      if (d["isAdmin"]) {
        this.userRole = UserRole.Admin;
      } else {
        this.userRole = UserRole.Volunteer;
      }
      if (notify) notifyListeners();
    } on Exception catch (e) {
      this.loginFailed("Invalid email or password");
    }
  }

  /// Deletes JWT and user stored
  Future<void> logOut() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'jwt');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    this.isLoggedIn = false;
    notifyListeners();
  }

  /// Handle UI update
  void successfulLogin() {
    this.isLoggedIn = true;
    this.failedLogIn = false;
    this.isLoading = false;
    notifyListeners();
  }

  /// Handle UI update
  void loginFailed(String err) {
    this.error = err;
    this.failedLogIn = true;
    this.isLoggedIn = false;
    this.isLoading = false;
    notifyListeners();
  }
}
