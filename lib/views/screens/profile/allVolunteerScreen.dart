import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'All Volunteer',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
          ),
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {})
          ],
          elevation: 0.8,
          centerTitle: true,
        ),
        body: ListOfVolunteers(),
      ),
    );
  }
}

List<VolunteerModel>? cachedVolunteers;

class ListOfVolunteers extends StatefulWidget {
  const ListOfVolunteers({
    Key? key,
  }) : super(key: key);

  @override
  _ListOfVolunteersState createState() => _ListOfVolunteersState();
}

class _ListOfVolunteersState extends State<ListOfVolunteers> {
  bool isLoading = false;
  List<VolunteerModel>? volunteers = cachedVolunteers;

  /// To be used for search
  List<VolunteerModel>? filteredVolunteers;

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
        volunteers?.add(
          VolunteerModel(
              eventIds: user["events"],
              name: user["name"],
              userId: user["_id"],
              id: user["BITS_ID"] ?? "2020QWE1234H",
              phoneNumber: user["phoneNumber"] ?? "1234567890",
              dateOfJoining: user["dateOfJoining"] ?? "Jan 1 2008",
              role: user["role"] ?? 'Volunteer',
              score: user["score"] ?? 0),
        );
      });
      cachedVolunteers = this.volunteers;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    return Container(
      child: SafeArea(
        child: Stack(fit: StackFit.expand, children: [
          Column(
            children: <Widget>[
              SizedBox(height: 60),
              // Text("All Volunteers", style: TextStyle(fontSize: 26)),
              if (isLoading) CircularProgressIndicator(),
              if (!isLoading &&
                  (volunteers == null || (volunteers?.isEmpty ?? true)))
                Center(child: Text("No volunteers found")),
              if (!isLoading)
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
                            itemCount: (volunteers?.length ?? 0) + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: SortChooseButton(onSelect: (filter) {
                                      volunteers?.sort((vModel, other) {
                                        if (filter == "name") {
                                          return vModel.name
                                              .compareTo(other.name);
                                        }
                                        return (vModel.score < other.score)
                                            ? 1
                                            : -1;
                                      });
                                      setState(() {});
                                    }),
                                  ),
                                );
                              }
                              return volunteers?[index - 1]
                                      .toExpansionTile(screenSize) ??
                                  Text("");
                              // return ListTile(
                              //   title: Text(
                              //     volunteers?[index].name ?? "User $index",
                              //     style: TextStyle(
                              //         color: Colors.black,
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.bold),
                              //   ),
                              //   subtitle: Text(
                              //     volunteers?[index].id ?? "ID",
                              //     style: TextStyle(
                              //         color: Colors.black,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.normal),
                              //   ),
                              // );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
          buildFloatingSearchBar(),
        ]),
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenSize = MediaQuery.of(context).size.width;

    return FloatingSearchBar(
      hint: 'Search volunteers...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 200),
      onQueryChanged: (query) {
        query = query.toLowerCase();
        this.filteredVolunteers = volunteers
            ?.where((element) =>
                element.name.toLowerCase().contains(query) ||
                element.BITS_ID.contains(query))
            .toList();
        setState(() {});
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.person_search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (filteredVolunteers?.length == volunteers?.length)
                  Text("Search for name or ID"),
                ...this
                        .filteredVolunteers
                        ?.map((v) => v.toExpansionTile(screenSize))
                        .toList() ??
                    []
              ],
            ),
          ),
        );
      },
    );
  }
}

class SortChooseButton extends StatefulWidget {
  const SortChooseButton({Key? key, required this.onSelect}) : super(key: key);
  final void Function(String) onSelect;
  @override
  _SortChooseButtonState createState() => _SortChooseButtonState();
}

class _SortChooseButtonState extends State<SortChooseButton> {
  String dropdownValue = "name";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
        widget.onSelect(newValue!);
      },
      items: <String>['Name', 'Score']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value.toLowerCase(),
          child: Text("Sort by $value"),
        );
      }).toList(),
    );
  }
}
