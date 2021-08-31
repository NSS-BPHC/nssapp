import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nssapp/data/volunteerData.dart';
import 'package:nssapp/models/volunteerModel.dart';
import 'package:nssapp/services/api.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/widgets/panelCard.dart';

class AllVolunteerScreen extends StatefulWidget {
  @override
  _AllVolunteerScreenState createState() => _AllVolunteerScreenState();
}

class _AllVolunteerScreenState extends State<AllVolunteerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'All Volunteers',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: ListOfVolunteers(),
    );
  }
}

List<VolunteerModel>? volunteers;

class ListOfVolunteers extends StatefulWidget {
  const ListOfVolunteers({
    Key? key,
  }) : super(key: key);

  @override
  _ListOfVolunteersState createState() => _ListOfVolunteersState();
}

class _ListOfVolunteersState extends State<ListOfVolunteers> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this._getUsers();
  }

  Future<void> _getUsers() async {
    setState(() {
      isLoading = true;
    });
    if (volunteers != null && (volunteers?.isNotEmpty ?? false)) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final res = await getAllUsers();
    if (res != null) {
      final dec = json.decode(res);
      final users = dec["users"];

      volunteers = [];
      users?.forEach((user) {
        volunteers?.add(VolunteerModel(
            name: user["name"],
            id: user["BITS_ID"] ?? "2020QWE1234H",
            phoneNumber: user["phoneNumber"] ?? "1234567890",
            dateOfJoining: user["dateOfJoining"] ?? "Jan 1 2008",
            role: user["role"] ?? 'Volunteer'));
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Text("All Volunteers", style: TextStyle(fontSize: 26)),
            if (isLoading) CircularProgressIndicator(),
            if (!isLoading &&
                (volunteers == null || (volunteers?.isEmpty ?? true)))
              Center(child: Text("No volunteers found")),
            if (!isLoading && !(volunteers?.isEmpty ?? true))
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        volunteers = null;
                        await this._getUsers();
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: volunteers?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              volunteers?[index].name ?? "User $index",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              volunteers?[index].id ?? "ID",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          );
                        },
                      ),
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
