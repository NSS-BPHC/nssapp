import 'package:flutter/material.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/services/postApi.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/utilities/uiFunctions.dart';


class RegisteredVolunteerList extends StatefulWidget {
  final EventModel eventModel;
  const RegisteredVolunteerList({Key? key, required this.eventModel})
      : super(key: key);

  @override
  _RegisteredVolunteerListState createState() => _RegisteredVolunteerListState();
}

class _RegisteredVolunteerListState extends State<RegisteredVolunteerList> {
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
    final users = widget.eventModel.usersWithNames;

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
  }
}
