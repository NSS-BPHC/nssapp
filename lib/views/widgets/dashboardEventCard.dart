import 'package:flutter/material.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/models/userModel.dart';
import 'package:nssapp/services/getApi.dart';
import 'package:nssapp/services/postApi.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/events/volunteerEventRegistraion.dart';
import 'package:provider/provider.dart';

class DashBoardEventCard extends StatefulWidget {
  final EventModel eventModel;

  const DashBoardEventCard({Key? key, required this.eventModel})
      : super(key: key);

  @override
  _DashBoardEventCardState createState() => _DashBoardEventCardState();
}

class _DashBoardEventCardState extends State<DashBoardEventCard> {
  @override
  Widget build(BuildContext context) {
    final userID = context.read<LoginManager>().user.id;
    final isAdmin = context.watch<LoginManager>().userRole == UserRole.Admin;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        onTap: _handleEventClick,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.tertiaryColor,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.eventModel.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.place),
                            SizedBox(width: 5.0),
                            Text(
                              widget.eventModel.location,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.eventModel.date.toString(),
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "Organised by :  ",
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.eventModel.organiser,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.eventModel.startTime,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        Text(
                          widget.eventModel.endTime,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    if (!Provider.of<LoginManager>(context).isVisitor)
                      Container(
                        decoration: BoxDecoration(
                            color: widget.eventModel.closed ||
                                    widget.eventModel.noOfVolunteers <=
                                        widget.eventModel.users.length
                                ? Colors.red
                                : widget.eventModel.hasRegistered(userID)
                                    ? Colors.green
                                    : isAdmin
                                        ? Colors.green
                                        : widget.eventModel.isInTheFuture
                                            ? Color(0xff5271ff)
                                            : Colors.blueGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.eventModel.hasRegistered(userID) && !isAdmin
                                ? "Registered"
                                : widget.eventModel.closed
                                    ? "Closed"
                                    : widget.eventModel.noOfVolunteers <=
                                            widget.eventModel.users.length
                                        ? "Event full"
                                        : isAdmin
                                            ? "Close Event"
                                            : widget.eventModel.isInTheFuture
                                                ? "Register"
                                                : "Completed", //for safety
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleEventClick() async {
    if (context.read<LoginManager>().isVisitor || widget.eventModel.closed)
      return;
    // final isAdmin = context.read<LoginManager>().userRole == UserRole.Admin;
    _registerForEvent();
    // if (isAdmin) {
    //   _showCloseEventDialog();
    // } else {
    //   _registerForEvent();
    // }
  }

  Future<void> _registerForEvent() async {
    final id = context.read<LoginManager>().user.id;
    final isAdmin = context.read<LoginManager>().isAdmin;
    if (widget.eventModel.isInTheFuture) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VolunteerEventRegistrationScreen(
              eventModel: widget.eventModel, userId: id, isAdmin: isAdmin),
        ),
      );
      // update this event in UI
      // if user takes action widget.eventModel gets updated
      setState(() {});
    }
  }

  Future<void> _showCloseEventDialog() async {
    final currentContext = context;
    if (widget.eventModel.closed) {
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(
              isLoading
                  ? "Closing, please wait..."
                  : "Close event \"${widget.eventModel.title}\"",
              style: TextStyle(fontSize: 22),
            ),
            content: Text(
                (isLoading
                    ? "Closing event"
                    : "Do you want to close this event? By closing this event new volunteers will no longer be able to register and ${widget.eventModel.score} points will be awarded to ${widget.eventModel.users.length} volunteers.\n"),
                style: TextStyle(
                    fontFamily: "Roboto",
                    color: AppTheme.textBlackColor,
                    fontSize: 16)),
            actions: [
              if (!isLoading)
                TextButton(
                  child: Text("Cancel", style: TextStyle(fontFamily: "Roboto")),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              if (!isLoading)
                TextButton(
                  child: Text("Close it",
                      style: TextStyle(
                          fontFamily: "Roboto",
                          color: AppTheme.secondaryColor)),
                  onPressed: () async {
                    if (isLoading) return;
                    setState(() {
                      isLoading = true;
                    });
                    final res = await closeEvent(widget.eventModel.id);
                    if (!res) {
                      setState(() {
                        isLoading = false;
                      });
                      // print("Mwahaha");
                      ScaffoldMessenger.of(currentContext)
                          .showSnackBar(SnackBar(
                        content: Text("Failed to close event"),
                      ));
                      // currentContext
                      //     .read<GetAPIProvider>()
                      //     .loadEventsUI(isLoading: false);
                      Navigator.pop(context);
                      return;
                    }
                    currentContext.read<GetAPIProvider>().getEvents();
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
