import 'package:flutter/material.dart';
import 'package:nssapp/utilities/styling.dart';

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

  late DateTime firstDate;
  late TimeOfDay eventTime = TimeOfDay(hour: 9, minute: 0);

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
      return '${eventTime.hour}:${eventTime.minute}';
    }
  }

  Future pickEventTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: eventTime,
    );
    if (newTime == null) return;
    setState(() {
      eventTime = newTime;
    });
  }

  final maxLines = 10;

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
      body: Padding(
        padding: AppTheme.screenPadding,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Location',
                  ),
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
                                style: Theme.of(context).textTheme.headline4,
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
                                  style: Theme.of(context).textTheme.headline4,
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
                child: TextField(
                  controller: organiserController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Organiser',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Slots',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: maxLines * 24,
              child: TextField(
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
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: Color(0xff5271ff),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
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
