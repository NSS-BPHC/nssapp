import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nssapp/services/getApi.dart';
import 'package:nssapp/services/postApi.dart' as api;
import 'package:nssapp/utilities/styling.dart';
import 'package:provider/provider.dart';

class AddEventsScreen extends StatefulWidget {
  const AddEventsScreen({Key? key}) : super(key: key);

  @override
  _AddEventsScreenState createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final organiserController = TextEditingController();
  final descriptionController = TextEditingController();
  final durationController = TextEditingController();
  final numberController = TextEditingController();
  final scoreController = TextEditingController(text: "10");

  final _formKey = GlobalKey<FormState>();

  bool submitLoading = false;

  late DateTime firstDate;
  // @saiankit
  // Akshat has no clue why "late" was used with assignment like so: hence he has changed to a nullable type instead
  // late TimeOfDay eventTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay? eventTime; //= TimeOfDay(hour: 9, minute: 0);

  void selectFirstDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != firstDate) {
      setState(() {
        firstDate = picked;
      });
    }
  }

  String? getText() {
    if (eventTime == null) {
      return 'SelectTime';
    } else {
      return '${eventTime?.hour}:${eventTime?.minute}';
    }
  }

  Future pickEventTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: eventTime ?? TimeOfDay.now(),
    );
    if (newTime == null) return;
    setState(() {
      eventTime = newTime;
    });
  }

  static const maxLines = 10;

  @override
  void initState() {
    firstDate = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Add Event',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: AppTheme.screenPadding,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    child: _defaultField(
                      textEditingController: titleController,
                      hintText: "Title",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    child: _defaultField(
                      textEditingController: locationController,
                      hintText: "Location",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Event Details'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => selectFirstDate(context),
                              child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    '${firstDate.day} ${months[firstDate.month - 1]} ${firstDate.year}',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => pickEventTime(context),
                              child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: 100,
                                    child: Text(
                                      getText().toString(),
                                      style:
                                          Theme.of(context).textTheme.headline4,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    child: _defaultField(
                      textEditingController: organiserController,
                      hintText: "Organiser",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 200,
                          child: _defaultField(
                              textEditingController: durationController,
                              hintText: "Duration(min)",
                              textInputType: TextInputType.number)
                          // child: TextField(
                          //   keyboardType: TextInputType.number,
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(),
                          //     hintText: 'Duration of event',
                          //   ),
                          // ),
                          ),
                      SizedBox(
                        width: 150,
                        child: _defaultField(
                            textEditingController: scoreController,
                            hintText: "Score",
                            textInputType: TextInputType.number),
                      )
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    width: 150,
                    child: _defaultField(
                        textEditingController: numberController,
                        hintText: "Max number of volunteers",
                        textInputType: TextInputType.number)
                    // child: TextField(
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     hintText: 'Duration of event',
                    //   ),
                    // ),
                    ),
                Container(
                  height: maxLines * 24,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description cannot be empty';
                      }
                      return null;
                    },
                    maxLines: maxLines,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Description',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: _handleSubmit,
                      child: submitLoading
                          ? SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator())
                          : Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xff5271ff),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _handleSubmit() async {
    if (submitLoading) return;
    if (!_formKey.currentState!.validate() || eventTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid input(s)')),
      );
      return;
    }

    setState(() {
      submitLoading = true;
    });
    final toAdd = addDuration(durationController.text);
    print(json.encode(toAdd));
    final endTimeHours = eventTime!.hour + (toAdd["hour"] ?? 0);
    final endTimeMinutes = eventTime!.minute + (toAdd["minutes"] ?? 0);
    int withdrawHours = eventTime!.hour; //- (toAdd["hours"] ?? 0);
    int withdrawMinutes = eventTime!.minute - (30);
    if (withdrawMinutes < 0) {
      withdrawMinutes += 60;
      if (withdrawHours == 1)
        withdrawHours = 12;
      else
        withdrawHours -= 1;
    }
    print(withdrawHours);
    // return;
    bool created = await api.createEvent({
      "title": titleController.text,
      "description": descriptionController.text,
      "location": locationController.text,
      "organiser": organiserController.text,
      "date":
          "${firstDate.day.toString().padLeft(2, "0")}/${firstDate.month.toString().padLeft(2, "0")}/${firstDate.year}",
      "score": int.tryParse(scoreController.text) ?? 10,
      "startTime": _getStartTime(eventTime),
      "withDrawTime": "${withdrawHours % 24}:${withdrawMinutes % 60}",
      "endTime": "${endTimeHours % 24}:${endTimeMinutes % 60}",
      "noOfVolunteers": int.parse(numberController.text)
    });

    setState(() {
      submitLoading = false;
    });
    if (!created) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to create event"),
      ));
    }
    context.read<GetAPIProvider>().getEvents(wasPulledToRefresh: true);
    Navigator.pop(context);
  }
}

String _getStartTime(TimeOfDay? timeOfDay) {
  if (timeOfDay == null) timeOfDay = TimeOfDay.now();
  // this.eventTime?.format(context).replaceAll(RegExp(r"[AP]M"), '') ??

  final hours = timeOfDay.hour;
  final min = timeOfDay.minute;
  return "${hours.toString().padLeft(2, "0")}:${min.toString().padLeft(2, "0")}";
}

Map<String, int> addDuration(String duration) {
  final durationNum = int.parse(duration);
  return {
    "minutes": durationNum % 60,
    "hour":
        durationNum ~/ 60, // this is the Truncating integer division operator
  };
}

List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

TextFormField _defaultField(
    {String? hintText,
    required TextEditingController textEditingController,
    TextInputType? textInputType,
    String? Function(String?)? validator}) {
  return TextFormField(
    validator: validator ??
        (value) {
          if (value == null || value.isEmpty) {
            return 'Cannot be empty';
          }
          return null;
        },
    controller: textEditingController,
    keyboardType: textInputType,
    style: TextStyle(color: Colors.black87),
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: hintText,
    ),
  );
}
