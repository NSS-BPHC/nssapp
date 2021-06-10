class EventModel {
  final String title;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime withDrawTime;
  final String description;
  final String organiser;
  final String location;
  final int noOfVolunteers;

  EventModel(
      {required this.title,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.withDrawTime,
      required this.description,
      required this.organiser,
      required this.location,
      required this.noOfVolunteers});
}
