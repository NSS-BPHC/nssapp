import 'package:flutter/material.dart';
import 'package:nssapp/data/eventsData.dart';
import 'package:nssapp/views/screens/dashboard/addEvents.dart';
import 'package:nssapp/views/widgets/dashboardEventCard.dart';

class UpcomingEventsComponent extends StatefulWidget {
  @override
  _UpcomingEventsComponentState createState() =>
      _UpcomingEventsComponentState();
}

class _UpcomingEventsComponentState extends State<UpcomingEventsComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Upcoming Events ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddEventsScreen()));
                  },
                  child: Icon(Icons.add)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: eventsData.length,
            itemBuilder: (context, index) {
              return DashBoardEventCard(
                eventModel: eventsData[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
