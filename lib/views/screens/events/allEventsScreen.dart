import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:nssapp/data/eventsData.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/dashboard/addEvents.dart';
import 'package:nssapp/views/widgets/allEventCard.dart';

class AllEventsScreen extends StatefulWidget {
  @override
  _AllEventsScreenState createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
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
          elements: eventsData,
          groupBy: (element) => element.date[3] + element.date[4],
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) => (item1.date[0] + item1.date[1])
              .compareTo((item2.date[0] + item2.date[1])),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              months[int.parse(value)-1],
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
