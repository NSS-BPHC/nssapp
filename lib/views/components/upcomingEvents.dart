import 'package:flutter/material.dart';
import 'package:nssapp/views/screens/volunteerProfile.dart';
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
              Icon(Icons.edit),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return DashBoardEventCard(
                eventModel: items[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
