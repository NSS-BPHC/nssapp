import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:nssapp/utilities/styling.dart';
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
      body: Padding(
        padding: AppTheme.screenPadding,
        child: GroupedListView<dynamic, String>(
          elements: items,
          groupBy: (element) => element.location,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) => item1.title.compareTo(item2.title),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              // textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (c, element) {
            return AllEventCard(
              eventModel: element,
            );
          },
        ),
      ),
    );
  }
}
