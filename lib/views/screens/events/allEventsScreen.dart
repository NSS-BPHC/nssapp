import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:nssapp/utilities/utilityFunctions.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/services/getApi.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/dashboard/addEvents.dart';
import 'package:nssapp/views/widgets/allEventCard.dart';
import 'package:provider/provider.dart';

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
        padding: EdgeInsets.all(0),
        child: EventsList(),
      ),
    );
  }
}

class EventsList extends StatelessWidget {
  const EventsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<GetAPIProvider>().getEvents();
    bool loading = context.watch<GetAPIProvider>().eventsLoading;
    return Padding(
      padding: AppTheme.screenPadding,
      child:
          loading ? Center(child: CircularProgressIndicator()) : _EventsList(),
    );
  }
}

class _EventsList extends StatefulWidget {
  @override
  __EventsListState createState() => __EventsListState();
}

class __EventsListState extends State<_EventsList> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<GetAPIProvider>(context).eventsData;
    events?.sort(
        (a, b) => a.date.toDateTime().isBefore(b.date.toDateTime()) ? 1 : 0);
    // final displayedEvents =
    // (events?.length ?? 0) <= 3 ? _eventsPad(events ?? []) : events;
    // print(displayedEvents);
    return GroupedListView<dynamic, String>(
      physics: BouncingScrollPhysics(),
      elements: events ?? [], //eventsData,
      groupBy: (element) => element.date[3] + element.date[4],
      groupComparator: (value1, value2) => value2.compareTo(value1),
      // itemComparator: (item1, item2) => (item1.date[0] + item1.date[1])
      //     .compareTo((item2.date[0] + item2.date[1])),
      // itemComparator: (a, b) =>
      //     a.date.toDateTime().isAfter(b.date.toDateTime()) ? 1 : 0,
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: true,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          months[int.parse(value) - 1],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (c, element) {
        try {
          return AllEventCard(
            eventModel: element,
          );
        } on Exception catch (e) {
          return Container();
        }
      },
    );
  }
}

List<dynamic> _eventsPad(List<dynamic> events) {
  events.add(EventModel(
      id: '',
      title: '',
      date: '',
      startTime: 'startTime',
      endTime: 'endTime',
      withDrawTime: 'withDrawTime',
      location: 'location',
      description: 'description',
      organiser: 'organiser',
      noOfVolunteers: 2,
      score: 0,
      v: 0,
      eventModelId: 'eventModelId'));
  return events;
}
