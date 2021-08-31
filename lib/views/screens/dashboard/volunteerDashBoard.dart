import 'package:flutter/material.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/components/announcements.dart';
import 'package:nssapp/views/components/upcomingEvents.dart';
import 'package:nssapp/views/screens/dashboard/changeGreetings.dart';
import 'package:provider/provider.dart';

class VolunteerDashBoardScreen extends StatefulWidget {
  const VolunteerDashBoardScreen({Key? key}) : super(key: key);

  @override
  _VolunteerDashBoardScreenState createState() =>
      _VolunteerDashBoardScreenState();
}

class _VolunteerDashBoardScreenState extends State<VolunteerDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    /// The current user
    final user = context.watch<LoginManager>().user;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: AppTheme.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello ${user.name}!',
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
                  (1 == 2)
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeGreetingsScreen(),
                              ),
                            );
                          },
                          child: Icon(Icons.edit),
                        )
                      : Container(),
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
