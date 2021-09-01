import 'package:flutter/material.dart';
import 'package:nssapp/data/eventsData.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/utilities/utilityFunctions.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/models/userModel.dart';
import 'package:nssapp/services/getApi.dart';
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
  void initState() {
    super.initState();
    // context.read<GetAPIProvider>().getEvents();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin =
        context.watch<LoginManager>().userRole == UserRole.Admin;
    final eventsLength =
        context.watch<GetAPIProvider>().eventsData?.length ?? 0;
    final events1 = context.watch<GetAPIProvider>().eventsData ?? [];
    events1.sort(
        (a, b) => a.date.toDateTime().isBefore(b.date.toDateTime()) ? 1 : 0);
    final events = List<EventModel>.from(events1);
    events.removeWhere((element) => !element.isInTheFuture);
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
                      onTap: () async {
                        await Navigator.push(
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
          child: (context.watch<GetAPIProvider>().eventsLoading)
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () async {
                    print("refresing");
                    await context
                        .read<GetAPIProvider>()
                        .getEvents(wasPulledToRefresh: true);
                  },
                  child: eventsLength == 0
                      ? Center(child: Text("No events"))
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (eventsLength <= 3)
                              ? eventsLength + 1
                              : eventsLength,
                          itemBuilder: (context, index) {
                            if (index >= eventsLength)
                              return SizedBox(height: 100);
                            // if (events)
                            //   return Container();
                            // else
                            try {
                              return DashBoardEventCard(
                                eventModel: events[index],
                              );
                            } catch (e) {
                              return SizedBox();
                            }
                          },
                        ),
                ),
        ),
      ],
    );
  }
}
