import 'package:flutter/material.dart';
import 'package:nssapp/data/eventsData.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/models/userModel.dart';
import 'package:nssapp/views/screens/dashboard/addEvents.dart';
import 'package:nssapp/views/widgets/dashboardEventCard.dart';
import 'package:provider/provider.dart';

class UpcomingEventsComponent extends StatefulWidget {
  @override
  _UpcomingEventsComponentState createState() =>
      _UpcomingEventsComponentState();
}

class _UpcomingEventsComponentState extends State<UpcomingEventsComponent> {
  @override
  Widget build(BuildContext context) {
    final bool isAdmin =
        context.watch<LoginManager>().userRole == UserRole.Admin;
    print(context.read<LoginManager>().user.email);
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
              (isAdmin)
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEventsScreen(),
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                    )
                  : Container(),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
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
