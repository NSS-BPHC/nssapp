import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/services/routes.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/more/successSuggestion.dart';
import 'package:nssapp/views/widgets/suggestionsList.dart';
import 'package:provider/provider.dart';

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
    final isAdmin = Provider.of<LoginManager>(context, listen: false).isAdmin;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          isAdmin ? "View Suggestions" : 'Drop Suggestions',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isAdmin
          ? SuggestionsList()
          : ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  child: TextField(
                    controller: titleController,
                    style: TextStyle(color: Colors.black),
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
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Suggestion',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: InkWell(
                    onTap: _onSubmit,
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: AppTheme.secondaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 20.0,
                          ),
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
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

  void _onSubmit() {
    final name = context.read<LoginManager>().user.name;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SuccessSuggestionScreen()));

    post(Uri.parse("$BASE_URL/suggestions"), body: {
      "title": titleController.text,
      "content": suggestionController.text,
      "username": name,
    });
    titleController.text = "";
    suggestionController.text = "";
  }
}
