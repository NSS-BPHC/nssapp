import 'package:flutter/material.dart';
import 'package:nssapp/views/screens/volunteerProfile.dart';
import 'package:nssapp/views/widgets/allEventCard.dart';

class VolunteerEventsScreen extends StatefulWidget {
  @override
  _VolunteerEventsScreenState createState() => _VolunteerEventsScreenState();
}

class _VolunteerEventsScreenState extends State<VolunteerEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'All Events',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return AllEventCard(
              eventModel: items[index],
            );
          },
        ),
      ),
    );
  }
}
