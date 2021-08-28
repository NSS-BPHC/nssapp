// ignore: camel_case_types
import 'package:nssapp/services/postApi.dart';

class AnnouncementModel {
  final String title;
  final String description;
  final String time;
  final String id;

  AnnouncementModel(
      {required this.time,
      required this.title,
      required this.description,
      required this.id});
  Future<bool> delete() async {
    final res = await deleteAnnouncement(this.id);
    return res;
  }
}
