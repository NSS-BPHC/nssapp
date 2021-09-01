import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;
import 'package:nssapp/services/routes.dart';

Future<bool> registerForEvent(String eventId) async {
  final url = "$BASE_URL/register-event/$eventId";
  final response = await _makeAuthorizedRequestTo(url, patch: true);
  print(response.body);
  return response.statusCode == 201;
}

Future<bool> createEvent(Map<String, dynamic> event) async {
  final url = "$BASE_URL/events";
  final response = await _makeAuthorizedRequestTo(url, post: true, data: event);
  print(response.body);
  print(response.statusCode);
  return response.statusCode == 201;
}

Future<bool> adminWithdrawParticipantFromEvent(
    {required String eventId, required userId}) async {
  final url = "$BASE_URL/admin/withdraw/$eventId/$userId";
  final response = await _makeAuthorizedRequestTo(url, delete: true);
  return response.statusCode == 201;
}

Future<bool> withdrawFromEvent(String eventId) async {
  final url = "$BASE_URL/register-event/$eventId";
  final response = await _makeAuthorizedRequestTo(
    url,
    delete: true,
  );
  return response.statusCode == 201;
}

Future<bool> createAnnouncement(
    {required String title, required String description}) async {
  final currentDate = DateTime.now();
  final date =
      "${currentDate.day}/${currentDate.month.toString().padLeft(2, "0")}/${currentDate.year}";
  final response = await _makeAuthorizedRequestTo("$BASE_URL/announcements",
      post: true,
      data: {
        "date": currentDate.toString(),
        "title": title,
        "description": description
      });
  return response.statusCode == 201;
}

Future<bool> deleteAnnouncement(String id) async {
  final url = "$BASE_URL/announcements/$id";
  final response = await _makeAuthorizedRequestTo(
    url,
    delete: true,
  );
  return response.statusCode == 201;
}

Future<bool> closeEvent(String eventId) async {
  final url = "$BASE_URL/score/$eventId";
  final response = await _makeAuthorizedRequestTo(url, patch: true);
  return response.statusCode == 201;
}

Future<http.Response> getSuggestions() async {
  final url = "$BASE_URL/suggestions";
  return await _makeAuthorizedRequestTo(url, getRequest: true);
}

Future<http.Response> _makeAuthorizedRequestTo(String url,
    {Map<String, dynamic>? data,
    bool getRequest = false,
    bool post = false,
    bool delete = false,
    bool patch = false}) async {
  final storage = FlutterSecureStorage();
  final jwt = await storage.read(key: 'jwt');
  final d = json.decode(jwt ?? '{"token": "wed"}');
  print(d?['token']);
  final headers = {
    HttpHeaders.authorizationHeader: "Bearer ${d?['token']}",
    "Content-Type": "application/json"
  };
  print(json.encode(headers));
  if (getRequest) {
    return await http.get(Uri.parse(url), headers: headers);
  }
  if (post) {
    return await http.post(
      Uri.parse(url),
      body: json.encode(data),
      headers: headers,
    );
  }
  if (delete) {
    return await http.delete(
      Uri.parse(url),
      headers: headers,
    );
  }
  if (patch) {
    print(patch);
    return await http.patch(
      Uri.parse(url),
      headers: headers,
    );
  }
  return await http.get(
    Uri.parse(url),
    headers: headers,
  );
}
