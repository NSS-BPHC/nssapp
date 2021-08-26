import 'package:flutter/material.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/models/loginManager.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        onTap: () {
          final id = context.read<LoginManager>().user.id;
          if (widget.eventModel.isInTheFuture)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VolunteerEventRegistrationScreen(
                    eventModel: widget.eventModel, userId: id),
              ),
            );
        },
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
                    Container(
                      decoration: BoxDecoration(
                          color: widget.eventModel.hasRegistered(userID)
                              ? Colors.green
                              : widget.eventModel.isInTheFuture
                                  ? Color(0xff5271ff)
                                  : Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.eventModel.hasRegistered(userID)
                              ? "Registered"
                              : widget.eventModel.isInTheFuture
                                  ? "Register"
                                  : "Completed",
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
}
