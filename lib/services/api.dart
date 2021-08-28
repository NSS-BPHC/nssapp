// Routes available in routes.dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nssapp/services/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiResponse {
  String? data;
  String? apiError;
  ApiResponse({this.data, this.apiError});

  void handleLogin(http.Response response) {
    switch (response.statusCode) {
      case 200:
        storeJWT(response.body);
        this.data = response.body;
        break;
      case 401:
        this.apiError = "Failed to login";
        break;
      default:
        this.apiError = "An error occured. Please try again later.";
    }
  }
}

/// Saves JWT in secure storage
Future<void> storeJWT(String response) async {
  final storage = new FlutterSecureStorage();
  await storage.write(key: 'jwt', value: response);
}

/// Tries to log in
/// If Log in is successful, stores JWT in secure storage
Future<ApiResponse> login(
    {required String email, required String password}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final url = Uri.parse("$BASE_URL/users/login");
    final response =
        await http.post(url, body: {'email': email, "password": password});
    print(response.body);
    apiResponse.handleLogin(response);
  } on SocketException {
    apiResponse.apiError = "Connection error";
  }
  return apiResponse;
}

/// Get the full user data from backend and store it
///
/// If user data exists on the storage, no http call is made
/// Set `forceNewFetch` to true if data is to be fetched from the backend
/// (use when profile is updated)
Future<String> getAndStoreUserData(
    {String? jwt, bool forceNewFetch = false}) async {
  try {
    late final Map<String, dynamic> decoded;
    // if JWT is not provided, fetch it from storage
    if (jwt == null) {
      final storage = FlutterSecureStorage();
      jwt = await storage.read(key: 'jwt');
    }
    decoded = JwtDecoder.decode(jwt!);
    // print(decoded);
    // Check if user exists on device
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!forceNewFetch &&
        prefs.containsKey('user') &&
        prefs.getString('user') != null) {
      return prefs.getString('user') ?? "";
    } else {
      print("fetching new data");
      // Get the USER data
      final url = Uri.parse("$BASE_URL/users/${decoded['id']}");
      final response = await http.get(url);
      // Save the data
      prefs.setString('user', response.body);
      return response.body;
    }
  } catch (e) {
    return "Error";
  }
}

/// Get info about users of an event from the event ID
Future<List<dynamic>?> getEventUsers(String id) async {
  final response = await http.get(Uri.parse("$BASE_URL/events/$id"));
  if (response.statusCode == 200) {
    final dec = json.decode(response.body);
    return dec['users'];
  }
}

Future<String?> getOneEvent(String id) async {
  final response = await http.get(Uri.parse("$BASE_URL/events/$id"));
  if (response.statusCode == 200) {
    return response.body;
  }
}

/// Beware, the API response has the array within users object
Future<String?> getAllUsers() async {
  final response = await http.get(Uri.parse("$BASE_URL/users"));
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200 || response.statusCode == 201)
    return response.body;
}
