import 'package:flutter/material.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/services/api.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/events/eventDescription.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteerModel {
  final String name;
  final String BITS_ID;
  final String userId;
  final String phoneNumber;
  final String dateOfJoining;
  final String role;
  final int score;
  List<dynamic>? eventIds;
  List<EventModel>? eventModels;

  VolunteerModel({
    required this.name,
    required String id,
    this.userId = "test",
    required this.phoneNumber,
    required this.dateOfJoining,
    required this.role,
    this.score = 0,
    this.eventIds,
    this.eventModels,
  }) : this.BITS_ID = id;
  Future<List<Widget>?> getEvents(BuildContext context) async {
    if (eventModels == null) {
      this.eventModels = await getEventsForOneUser(this.userId);
    }
    print("event models");
    print(eventModels);
    if (eventModels == null) eventModels = [];
    return this
        .eventModels!
        .map((e) => ListTile(
              title: Text(e.title),
              subtitle: Text(e.description.substring(0, 16) + "..."),
              trailing: Icon(Icons.open_in_new),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDescription(eventModel: e),
                  ),
                );
              },
            ))
        .toList();
  }

  Widget toExpansionTile(double screenSize) {
    return VolunteerExpansionTile(
        screenSize: screenSize,
        score: score,
        name: name,
        BITS_ID: BITS_ID,
        eventIds: eventIds,
        phoneNumber: phoneNumber,
        model: this);
  }
}

class VolunteerExpansionTile extends StatefulWidget {
  const VolunteerExpansionTile({
    Key? key,
    required this.model,
    required this.screenSize,
    required this.score,
    required this.name,
    required this.BITS_ID,
    required this.eventIds,
    required this.phoneNumber,
  }) : super(key: key);
  final double screenSize;
  final int score;
  final String name;
  final String BITS_ID;
  final List<dynamic>? eventIds;
  final String phoneNumber;
  final VolunteerModel model;

  @override
  State<VolunteerExpansionTile> createState() => _VolunteerExpansionTileState();
}

class _VolunteerExpansionTileState extends State<VolunteerExpansionTile> {
  bool eventsLoading = false;
  // bool eventsLoaded = false;
  List<Widget>? events;
  void getEvents() async {
    setState(() {
      eventsLoading = true;
    });
    events = await widget.model.getEvents(context);
    setState(() {
      eventsLoading = false;
    });
    print(events);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 30),
            child: Text(
              widget.score.toString(),
              style: TextStyle(
                fontSize: 22,
                color: AppTheme.secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: 80.0, maxWidth: widget.screenSize * 0.7),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppTheme.textBlackColor,
                      ),
                    ),
                  ),
                  Text(widget.BITS_ID),
                  Text("Total events: ${widget.eventIds?.length ?? 0}")
                ],
              ),
            ),
          ),
        ],
      ),
      // subtitle: Text(id),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton.icon(
            onPressed: () {
              launch("tel://${widget.phoneNumber}");
            },
            icon: Icon(Icons.phone),
            label: Text("Call ${widget.phoneNumber}"),
          ),
          // child: InkWell(
          //     onTap: () {
          //       launch("tel://$phoneNumber");
          //     },
          //     child: Row(
          //       children: [
          //         Icon(Icons.phone),
          //         Text(this.phoneNumber),
          //       ],
          //     )),
        ),
        if (!eventsLoading && events == null)
          OutlinedButton.icon(
            onPressed: () {
              this.getEvents();
            },
            icon: Icon(Icons.event),
            label: Text("View their events"),
          ),
        if (eventsLoading) CircularProgressIndicator(),
        ...(events ?? [])
      ],
    );
  }
}
