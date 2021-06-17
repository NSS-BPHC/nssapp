import 'package:flutter/material.dart';
import 'package:nssapp/utilities/styling.dart';

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
        centerTitle: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Drop Suggestions',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
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
            padding: const EdgeInsets.all(100.0),
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 20.0,
                  ),
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
          ),
        ],
      ),
    );
  }
}
