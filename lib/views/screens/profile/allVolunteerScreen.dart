import 'package:flutter/material.dart';
import 'package:nssapp/data/volunteerData.dart';
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
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: volunteersData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        volunteersData[index].name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        volunteersData[index].id,
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
          ],
        ),
      ),
    );
  }
}
