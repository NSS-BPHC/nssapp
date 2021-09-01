import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;
import 'package:nssapp/models/announcementModel.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/services/routes.dart';

/// Handle get Events, get Users, get merch
class GetAPIProvider with ChangeNotifier {
  String? error;
  List<EventModel>? eventsData;
  List<AnnouncementModel>? announcements;

  bool eventsLoading = false;
  bool announcementsLoading = true;

  GetAPIProvider() {
    print("_______________");
    // this.getEvents();
    // this.getAnnouncements();
  }

  Future<void> getEvents({bool wasPulledToRefresh = false}) async {
    eventsData = [];
    eventsLoading = !wasPulledToRefresh;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse("$BASE_URL/events"));
      // print("The response is");
      // print(response.body);
      // print(json.decode(response.body));
      // getHttpJson("$BASE_URL/events");
      if (response.statusCode == 200)
        // final decodedRes = json.decode(response.body);
        for (var event in json.decode(response.body)) {
          print(event);
          try {
            eventsData?.add(EventModel.fromJson(event));
          } catch (e) {
            print(e);
          }
        }
      else
        error = "Something went wrong";
    } catch (e) {
      error = "Could not fetch events $e";
    } finally {
      eventsLoading = false;
      notifyListeners();
    }
  }

  Future<void> postEvent(EventModel event) async {
    try {
      final storage = new FlutterSecureStorage();
      final jwt = await storage.read(key: 'jwt');

      final response = http.post(Uri.parse("$BASE_URL/events"),
          body: event.toJson(), headers: {"authorization": "Bearer $jwt"});
      print(response);
    } catch (e) {
      error = "Could not create event";
    }
  }

  void loadAnnouncementsUI() {
    this.announcementsLoading = true;
    notifyListeners();
  }

  void loadEventsUI({bool isLoading = true}) {
    this.eventsLoading = isLoading;
    notifyListeners();
  }

  Future<void> getAnnouncements({bool wasPulledToRefresh = false}) async {
    announcements = [];
    announcementsLoading = !wasPulledToRefresh;
    try {
      notifyListeners();
    } on Exception catch (e) {}
    try {
      final response = await http.get(Uri.parse("$BASE_URL/announcements"));
      // print(json.decode(response.body));
      // getHttpJson("$BASE_URL/events");
      if (response.statusCode == 200) {
        // final decodedRes = json.decode(response.body);
        for (var event in json.decode(response.body)["announcements"]) {
          try {
            announcements?.add(
              AnnouncementModel(
                time: event["date"],
                title: event["title"],
                description: event["description"],
                id: event["_id"],
              ),
            );
          } catch (e) {
            print(e);
          }
        }
      } else
        error = "Something went wrong";
    } catch (e) {
      error = "Could not fetch announcements $e";
    } finally {
      announcementsLoading = false;
      notifyListeners();
    }
  }
}

Future<dynamic> getHttpJson(String url) async {
  final uri = Uri.parse(url);
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.getUrl(uri);
  request.headers.set('Content-type', 'application/json');

  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  final decoded = json.decode(reply);
  print(decoded.length);
  httpClient.close();
  return json.decode(reply);
}
