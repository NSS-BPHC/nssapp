import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.all(14.0),
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
              Text(
                'Welcome Back',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Announcements',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                    announcement.length > 2
                        ? Text(
                            'View all',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: announcement.length > 2 ? 2 : announcement.length,
                  itemBuilder: (context, index) {
                    return AnnouncementCard(
                      announcementModel: announcement[index],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Upcoming Events',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.edit),
                    ],
                  ),
                ],
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
          ),
        ),
      ),
    );
  }
}
