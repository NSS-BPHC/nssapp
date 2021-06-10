import 'package:flutter/material.dart';
import 'package:nssapp/views/screens/volunteerProfile.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
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
    );
  }
}
