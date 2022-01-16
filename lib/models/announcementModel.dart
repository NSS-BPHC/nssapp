// ignore: camel_case_types
import 'package:intl/intl.dart';
import 'package:nssapp/services/postApi.dart';

class AnnouncementModel {
  final String title;
  final String description;
  final String _time;
  final String id;

  AnnouncementModel(
      {required String time,
      required this.title,
      required this.description,
      required this.id})
      : this._time = time;
  Future<bool> delete() async {
    final res = await deleteAnnouncement(this.id);
    return res;
  }

  DateTime get timeAsDateTime {
    final format = DateFormat("dd/mm/yyyy HH:mm");
    return format.parse(this._time);
  }

  /// Get a formatted time as string to display
  String get time {
    final parsed = DateTime.tryParse(this._time);
    if (parsed != null) {
      return "${parsed.day}/${parsed.month}/${parsed.year} ${parsed.hour}:${parsed.minute}";
    }
    return this._time;
  }
}
