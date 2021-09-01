import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nssapp/models/suggestionsModel.dart';
import "package:nssapp/services/postApi.dart";
import 'package:nssapp/views/widgets/adminSuggestionsCard.dart';

class SuggestionsList extends StatefulWidget {
  const SuggestionsList({Key? key}) : super(key: key);

  @override
  _SuggestionsListState createState() => _SuggestionsListState();
}

class _SuggestionsListState extends State<SuggestionsList> {
  List<Suggestion>? suggestions;
  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    suggestions = [];
    final response = await getSuggestions();

    final data = jsonDecode(response.body);
    final List<Map<String, dynamic>> json = data["suggestions"];
    suggestions = json.map((e) => Suggestion.fromJson(e)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return suggestions == null
        ? Center(child: CircularProgressIndicator())
        : suggestions?.length == 0
            ? Center(child: Text("No suggestions posted yet"))
            : ListView.builder(
                itemCount: suggestions?.length ?? 0,
                itemBuilder: (context, index) => SuggestionCard(
                  suggestion: suggestions![index],
                ),
              );
  }
}
