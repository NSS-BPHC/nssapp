import 'package:flutter/material.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/components/announcements.dart';
import 'package:nssapp/views/components/upcomingEvents.dart';
import 'package:nssapp/views/screens/changeGreetings.dart';
import 'package:nssapp/views/screens/volunteerProfile.dart';
import 'package:nssapp/views/widgets/announcementCard.dart';
import 'package:nssapp/views/widgets/dashboardEventCard.dart';

class VolunteerDashBoardScreen extends StatefulWidget {
  const VolunteerDashBoardScreen({Key? key}) : super(key: key);

  @override
  _VolunteerDashBoardScreenState createState() =>
      _VolunteerDashBoardScreenState();
}

class _VolunteerDashBoardScreenState extends State<VolunteerDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: AppTheme.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Rohith!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeGreetingsScreen()));
                      },
                      child: Icon(Icons.edit)),
                ],
              ),
              AnnouncementsComponent(),
              Expanded(child: UpcomingEventsComponent()),
            ],
          ),
        ),
      ),
    );
  }
}
