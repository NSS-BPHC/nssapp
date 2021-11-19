import 'package:flutter/material.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/services/postApi.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/utilities/uiFunctions.dart';


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
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() {
      isLoading = true;
    });
    await widget.eventModel.updateThisWithUserDetails();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = widget.eventModel.usersWithNames; //?.map((element) {
    //   return Text(element["name"] ?? "",
    //       style:
    //           const TextStyle(fontSize: 17, fontWeight: FontWeight.w300));
    // }) ??
    // [];

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
                  ...(users?.map((e) => Row(
                            children: [
                              Text(e["name"] ?? ''),
                              SizedBox(width: 5),

                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showConfirmDialog(context,
                                        title: "Withdraw ${e["name"]}?",
                                        content:
                                            "Removes this participant from this event. Closing this event will not award points to ${e["name"]}",
                                        onConfirm: () async {
                                      final res =
                                          await adminWithdrawParticipantFromEvent(
                                              eventId: widget.eventModel.id,
                                              userId: e["_id"]);
                                      if (!res) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Failed to withdraw ${e['name']}"),
                                        ));
                                        return;
                                      }
                                      widget.eventModel.usersWithNames
                                          ?.removeWhere((element) =>
                                              element["name"] == e["name"]);
                                      widget.eventModel.users.removeWhere(
                                          (element) =>
                                              element["name"] == e["name"]);
                                      setState(() {});
                                    });
                                  }),
                            ],
                          )) ??
                      []),
                  if (users?.isEmpty ?? true)
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
