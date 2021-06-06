import 'package:flutter/material.dart';
import 'package:nssapp/views/widgets/eventCard.dart';

class VolunteerProfileScreen extends StatefulWidget {
  const VolunteerProfileScreen({Key? key}) : super(key: key);

  @override
  _VolunteerProfileScreenState createState() => _VolunteerProfileScreenState();
}

final List<EventModel> items = [
  EventModel(title: "Govt School Visit", date: "21-Sept-2021", score: 10),
  EventModel(title: "Govt School Visit", date: "21-Sept-2021", score: 10),
  EventModel(title: "Govt School Visit", date: "21-Sept-2021", score: 10),
  EventModel(title: "Govt School Visit", date: "21-Sept-2021", score: 10),
];

class EventModel {
  final String title;
  final String date;
  final int score;

  EventModel({required this.title, required this.date, required this.score});
}

class _VolunteerProfileScreenState extends State<VolunteerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rohith Kumar Gattu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Core Team Member',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      '2019A7PS0049H',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                Container(
                  width: 80.0,
                  height: 80.0,
                  margin: EdgeInsets.only(left: 80),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '100',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(
                  width: 5,
                ),
                Text('9502986243')
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(
                  width: 5,
                ),
                Text('01-Sept 2019'),
                SizedBox(
                  width: 5,
                ),
                Text('-'),
                SizedBox(
                  width: 5,
                ),
                Text('present')
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  'Events Participated',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(
                  width: 150,
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return EventCard(
                  eventModel: items[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
