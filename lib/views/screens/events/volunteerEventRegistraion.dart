import 'package:flutter/material.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/services/getApi.dart';
import 'package:nssapp/services/postApi.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/events/successRegistration.dart';
import 'package:nssapp/views/widgets/eventVolunteersList.dart';
import 'package:nssapp/views/widgets/registeredVolunteersList.dart';
import 'package:provider/provider.dart';

enum RegState { loading, no, yes, canWithdraw, alreadyDone }

class VolunteerEventRegistrationScreen extends StatefulWidget {
  final EventModel eventModel;
  final String userId;
  final bool isAdmin;

  const VolunteerEventRegistrationScreen(
      {Key? key,
      required this.eventModel,
      required this.userId,
      required this.isAdmin})
      : super(key: key);

  @override
  _VolunteerEventRegistrationScreenState createState() =>
      _VolunteerEventRegistrationScreenState();
}

class _VolunteerEventRegistrationScreenState
    extends State<VolunteerEventRegistrationScreen> {
  RegState registrationAvailableLoading = RegState.loading;
  @override
  void initState() {
    super.initState();
    if (!widget.isAdmin)
      _fetchAvailability();
    else
      setState(() {
        registrationAvailableLoading = RegState.alreadyDone;
      });
  }

  Future<void> _fetchAvailability() async {
    if (widget.eventModel.isInTheFuture) {
      if (widget.eventModel.users.contains(widget.userId)) {
        setState(() {
          registrationAvailableLoading = widget.eventModel.canWithdraw
              ? RegState.canWithdraw
              : RegState.alreadyDone;
        });
        return;
      }
      final res = await widget.eventModel.canBeRegisteredFor;
      setState(() {
        registrationAvailableLoading = ((res) ? RegState.yes : RegState.no);
      });
    } else {
      setState(() {
        registrationAvailableLoading = RegState.no;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 32.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 50),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.eventModel.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    EventLocationAndOrganiser(widget: widget),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(width: 5.0),
                                Text(
                                  widget.eventModel.date.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.alarm),
                                SizedBox(width: 5.0),
                                Text(
                                  //TODO Uhh I should do a better job of rounding off times instead of removing the seconds part with a regexp
                                  // "${widget.eventModel.startTime.replaceFirst(RegExp(r":\d+$"), "")} - ${widget.eventModel.endTime.replaceFirst(RegExp(r":\d+$"), "")}",
                                  "${widget.eventModel.startTime} - ${widget.eventModel.endTime}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 18),
                          height: 50.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryColor,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.people,
                                  color: Colors.white,
                                ),
                                Text(
                                  "${widget.eventModel.users.length} / ${widget.eventModel.noOfVolunteers}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Description :',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Text(
                      widget.eventModel.description,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Registrations close on ${widget.eventModel.date} at ${widget.eventModel.startTime}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Withdrawls close on ${widget.eventModel.date} at ${widget.eventModel.withDrawTime}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        )
                      ],
                    ),
                    if (widget.isAdmin)
                      EventVolunteerList(eventModel: widget.eventModel),
                    const SizedBox(height: 50.0),
                    if(!widget.isAdmin)
                      RegisteredVolunteerList(eventModel: widget.eventModel),
                    const SizedBox(height: 50.0),


                 // ],
            //    ),



             // ),
               Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: _registerSubmit,
                          child: Container(
                            //width: MediaQuery.of(context).size.width,
                           margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                            decoration: BoxDecoration(
                                color: registrationAvailableLoading ==
                                        RegState.loading
                                    ? Colors.blueAccent.shade100
                                    : AppTheme.secondaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                              child: registrationAvailableLoading ==
                                      RegState.loading
                                  ? CircularProgressIndicator()
                                  : Text(
                                      widget.isAdmin
                                          ? widget.eventModel.closed
                                              ? "Event Closed"
                                              : "Close Event"
                                          : registrationAvailableLoading ==
                                                  RegState.yes
                                              ? "Register for Event"
                                              : registrationAvailableLoading ==
                                                      RegState.no
                                                  ? "Event closed"
                                                  : registrationAvailableLoading ==
                                                          RegState.alreadyDone
                                                      ? "Registered"
                                                      : "Withdraw",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ],
                ),
    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _registerSubmit() async {
    print("Asdasd");
    if (widget.isAdmin) {
      print("Asdasd");
      _showCloseEventDialog();
      return;
    }
    switch (registrationAvailableLoading) {
      case RegState.loading:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Please wait while we are fetching availability")));
        return;
      case RegState.no:
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Cannot register, try next time!")));
        return;
      case RegState.alreadyDone:
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Haha! You cannot register again")));
        return;
      case RegState.canWithdraw:
        _withdraw();
        return;
      case RegState.yes:
      default:
    }
    setState(() {
      registrationAvailableLoading = RegState.loading;
    });
    final res = await registerForEvent(widget.eventModel.id);
    if (res) {
      widget.eventModel.users.add(widget.userId);
      setState(() {
        registrationAvailableLoading = RegState.alreadyDone;
        this._fetchAvailability();
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SuccessRegistration()));
    } else {
      setState(() {
        registrationAvailableLoading = widget.eventModel.canWithdraw
            ? RegState.canWithdraw
            : RegState.alreadyDone;
      });
    }
  }

  Future<void> _withdraw() async {
    setState(() {
      registrationAvailableLoading = RegState.loading;
    });
    final res = await withdrawFromEvent(widget.eventModel.id);
    // final res = true;
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Withdrawn from event successfully!")));
      widget.eventModel.users.remove(widget.userId);
      setState(() {
        registrationAvailableLoading = RegState.loading;
      });
      this._fetchAvailability();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed")));
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
                    // currentContext.read<GetAPIProvider>().getEvents();
                    await widget.eventModel.updateThisWithUserDetails();
                    Navigator.pop(context);
                    Navigator.pop(currentContext, true);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class EventLocationAndOrganiser extends StatelessWidget {
  const EventLocationAndOrganiser({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final VolunteerEventRegistrationScreen widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.place),
                SizedBox(width: 5.0),
                Text(
                  widget.eventModel.location,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                text: 'Organised By: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.secondaryColor,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.eventModel.organiser,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
