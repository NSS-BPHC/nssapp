import 'package:flutter/material.dart';
import 'package:nssapp/views/widgets/eventCard.dart';

class VolunteerProfileScreen extends StatefulWidget {
  const VolunteerProfileScreen({Key? key}) : super(key: key);

  @override
  _VolunteerProfileScreenState createState() => _VolunteerProfileScreenState();
}

final List<EventModel> items = [
  EventModel(title: "Govt School Visit", date: "21-Sep-2021", score: 0),
  EventModel(title: "Govt School Visit", date: "18-Sep-2021", score: 8),
  EventModel(title: "Govt School Visit", date: "06-Aug-2021", score: 10),
  EventModel(title: "Govt School Visit", date: "14-Jul-2021", score: 6),
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
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Rohith ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black),
            ),
            Text(
              'Kumar Gattu',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Core Team Member',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '2019A7PS0049H',
                      style: TextStyle(fontSize: 18),
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
                  ],
                ),
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
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
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Events Participated',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
