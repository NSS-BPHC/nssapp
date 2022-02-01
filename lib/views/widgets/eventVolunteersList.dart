import 'package:flutter/material.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/services/postApi.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/utilities/uiFunctions.dart';
import 'package:nssapp/views/screens/events/volunteerEventRegistration.dart';
import 'package:provider/provider.dart';

class CustomScore {
  final String id;
  String scoreToDecrease;

  CustomScore({required this.id, this.scoreToDecrease = "0"});
}

/// Shows the admin action buttons as well.
/// Only meant for admin view
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text("Participants",
            style: TextStyle(fontSize: 18, color: AppTheme.secondaryColor)),
        const SizedBox(height: 20),
        (isLoading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  ...(users?.map((e) => _UserCard(
                                user: e,
                                eventModel: widget.eventModel,
                                updateCallback: () {
                                  setState(() {});
                                },
                              )
                          // (e) => Row(
                          //   children: [
                          //     Text(e["name"] ?? ''),
                          //     SizedBox(width: 5),
                          //     IconButton(
                          //         icon: Icon(Icons.delete),
                          //         onPressed: () {
                          //           showConfirmDialog(context,
                          //               title: "Withdraw ${e["name"]}?",
                          //               content:
                          //                   "Removes this participant from this event. Closing this event will not award points to ${e["name"]}",
                          //               onConfirm: () async {
                          //             final res =
                          //                 await adminWithdrawParticipantFromEvent(
                          //                     eventId: widget.eventModel.id,
                          //                     userId: e["_id"]);
                          //             if (!res) {
                          //               ScaffoldMessenger.of(context)
                          //                   .showSnackBar(SnackBar(
                          //                 content: Text(
                          //                     "Failed to withdraw ${e['name']}"),
                          //               ));
                          //               return;
                          //             }
                          //             widget.eventModel.usersWithNames
                          //                 ?.removeWhere((element) =>
                          //                     element["name"] == e["name"]);
                          //             widget.eventModel.users.removeWhere(
                          //                 (element) =>
                          //                     element["name"] == e["name"]);
                          //             setState(() {});
                          //           });
                          //         }),
                          //   ],
                          // ),
                          ) ??
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

class _UserCard extends StatefulWidget {
  const _UserCard({
    Key? key,
    required this.user,
    required this.eventModel,
    required this.updateCallback,
  }) : super(key: key);
  final Map<String, dynamic> user;
  final EventModel eventModel;
  final Function updateCallback;
  @override
  __UserCardState createState() => __UserCardState();
}

class __UserCardState extends State<_UserCard> {
  int? score = 10;
  @override
  Widget build(BuildContext context) {
    if (score == null) score = widget.eventModel.score;
    final String name = widget.user["name"] ?? "User";
    return Card(
        elevation: 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("$name ($score)"),
              subtitle: Text(widget.user["BITS_ID"] ?? ""),
            ),
            if (!widget.eventModel.closed)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      showInputDialog(context,
                          title: "Enter score",
                          message: "Enter points to award $name",
                          onInput: (val) {
                        // widget.list.add(CustomScore(
                        //     id: widget.user["_id"], scoreToDecrease: val));
                        int? parsed = int.tryParse(val);
                        if (parsed == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Input not entered, invalid or 0"),
                          ));
                          return;
                        }
                        int newScore = parsed;
                        // int newScore = (widget.eventModel.score) -
                        // (int.tryParse(val) ?? 0);
                        // int newScore =
                        //     int.tryParse(val) ?? widget.eventModel.score;
                        if (newScore > 0 &&
                            newScore <= widget.eventModel.score) {
                          Provider.of<CustomScoreKeeper>(context, listen: false)
                              .addUser(
                                  widget.user["_id"],
                                  (widget.eventModel.score - newScore)
                                      .toString());
                          setState(() {
                            this.score = newScore;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "You can decrease score max by ${widget.eventModel.score - 1} only."),
                          ));
                        }
                      });
                    },
                    icon: Icon(Icons.edit),
                    label: Text("Edit"),
                  ),
                  SizedBox(width: 8),
                  // Remove button
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                      // foregroundColor:
                      //     MaterialStateProperty.all(Colors.redAccent),
                    ),
                    onPressed: () {
                      showConfirmDialog(context,
                          title: "Withdraw ${widget.user['name']}?",
                          content:
                              "Removes this participant from this event. Closing this event will not award points to $name",
                          onConfirm: () async {
                        // final res = await adminWithdrawParticipantFromEvent(
                        //     eventId: widget.eventModel.id,
                        //     userId: widget.user["_id"]);
                        final res = true;
                        if (!res) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Failed to withdraw $name"),
                          ));
                          return;
                        }
                        try {
                          widget.eventModel.usersWithNames?.removeWhere(
                              (element) => element["name"] == name);
                          widget.updateCallback();
                          print(widget.eventModel.users);
                          widget.eventModel.users
                              .removeWhere((element) => element == name);
                        } on Exception catch (e) {
                          Navigator.pop(context);
                        }
                      });
                    },
                    icon: Icon(Icons.delete),
                    label: Text("Remove"),
                  ),
                ],
              )
          ],
        ));
  }
}
