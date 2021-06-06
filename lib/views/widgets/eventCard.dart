import 'package:flutter/material.dart';
import 'package:nssapp/views/screens/volunteerProfile.dart';

class EventCard extends StatefulWidget {
  final EventModel eventModel;

  const EventCard({Key? key, required this.eventModel}) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black),
          //color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.eventModel.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.eventModel.date,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                width: 100,
              ),
              Text(
                widget.eventModel.score.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              )
            ],
          ),
        ),
      ),
    );
  }
}
