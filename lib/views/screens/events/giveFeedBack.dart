import 'package:flutter/material.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/events/sucess.dart';

class GiveFeedBackScreen extends StatefulWidget {
  const GiveFeedBackScreen({Key? key}) : super(key: key);

  @override
  _GiveFeedBackScreenState createState() => _GiveFeedBackScreenState();
}

class _GiveFeedBackScreenState extends State<GiveFeedBackScreen> {
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
          'Give FeedBack',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: maxLines * 24,
            margin: EdgeInsets.all(12),
            child: TextField(
              maxLines: maxLines,
              controller: suggestionController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'FeedBack',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SuccessFeedback()));
              },
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
          ),
        ],
      ),
    );
  }
}
