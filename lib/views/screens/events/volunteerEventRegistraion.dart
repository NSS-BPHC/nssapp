import 'package:flutter/material.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/services/postApi.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/events/successRegistration.dart';

enum RegState { loading, no, yes, canWithdraw, alreadyDone }

class VolunteerEventRegistrationScreen extends StatefulWidget {
  final EventModel eventModel;
  final String userId;

  const VolunteerEventRegistrationScreen(
      {Key? key, required this.eventModel, required this.userId})
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
    _fetchAvailability();
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Stack(
          children: [
            Column(
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
                              "${widget.eventModel.startTime.replaceFirst(RegExp(r":\d+$"), "")} - ${widget.eventModel.endTime.replaceFirst(RegExp(r":\d+$"), "")}",
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
                      'Registrations close on ${widget.eventModel.date} at ${widget.eventModel.startTime.replaceFirst(RegExp(r":\d+$"), "")}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Withdrawls close on ${widget.eventModel.date} at ${widget.eventModel.withDrawTime.replaceFirst(RegExp(r":\d+$"), "")}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(height: 50.0),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          decoration: BoxDecoration(
                              color: registrationAvailableLoading ==
                                      RegState.loading
                                  ? Colors.blueAccent.shade100
                                  : AppTheme.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: registrationAvailableLoading ==
                                    RegState.loading
                                ? CircularProgressIndicator()
                                : Text(
                                    registrationAvailableLoading == RegState.yes
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
    );
  }

  Future<void> _registerSubmit() async {
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
