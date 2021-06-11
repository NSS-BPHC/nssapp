import 'package:flutter/material.dart';

class VolunteerDropSuggestionsScreen extends StatefulWidget {
  const VolunteerDropSuggestionsScreen({Key? key}) : super(key: key);

  @override
  _VolunteerDropSuggestionsScreenState createState() =>
      _VolunteerDropSuggestionsScreenState();
}

class _VolunteerDropSuggestionsScreenState
    extends State<VolunteerDropSuggestionsScreen> {
  final titleController = TextEditingController();
  final suggestionController = TextEditingController();
  final maxLines = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            )),
        title: Text(
          'Drop Suggestions',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            // methods and listeners are yet to be implemented in titleController, suggestionController
            Container(
              margin: EdgeInsets.all(12),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
            ),
            Container(
              height: maxLines * 24,
              margin: EdgeInsets.all(12),
              child: TextField(
                maxLines: maxLines,
                controller: suggestionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Suggestion',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
