import 'package:flutter/material.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/utilities/styling.dart';

class EventVolunteerList extends StatefulWidget {
  final EventModel eventModel;
  const EventVolunteerList({Key? key, required this.eventModel})
      : super(key: key);

  @override
  _EventVolunteerListState createState() => _EventVolunteerListState();
}

class _EventVolunteerListState extends State<EventVolunteerList> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    _fetch();
  }

  void _fetch() async {
    await widget.eventModel.updateThisWithUserDetails();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = widget.eventModel.usersWithNames?.map((element) {
          return Text(element["name"] ?? "",
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.w300));
        }) ??
        [];
    return Column(
      children: [
        const SizedBox(height: 20),
        Text("Participants",
            style: TextStyle(fontSize: 18, color: AppTheme.secondaryColor)),
        const SizedBox(height: 20),
        (isLoading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  ...users,
                  if (users.isEmpty)
                    Text(
                      "No participants yet",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                ],
              )),
      ],
    );
    // return ListView.builder(itemBuilder: (context, index) {
    // return isLoading
    //     ? CircularProgressIndicator()
    //     : Text(widget.eventModel.usersWithNames?[index]["name"] ?? "");
    // });
  }
}
