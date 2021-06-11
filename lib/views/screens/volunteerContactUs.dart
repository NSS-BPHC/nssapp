import 'package:flutter/material.dart';
import 'package:nssapp/views/screens/volunteerProfile.dart';
import 'package:nssapp/views/widgets/panelCard.dart';

class VolunteerContactUs extends StatefulWidget {
  const VolunteerContactUs({Key? key}) : super(key: key);

  @override
  _VolunteerContactUsState createState() => _VolunteerContactUsState();
}

class _VolunteerContactUsState extends State<VolunteerContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
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
          'Contact Us',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
        ),
      
      ),
      body: Container(
        child: ListView.builder(
              shrinkWrap: true,
              itemCount: panel.length,
              itemBuilder: (context, index) {
                return PanelCard(
                   volunteerModel: panel[index],
                );
              },
            ),
      ),
    );
  }
}
