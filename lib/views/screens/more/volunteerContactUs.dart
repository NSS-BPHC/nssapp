import 'package:flutter/material.dart';
import 'package:nssapp/data/volunteerData.dart';
import 'package:nssapp/views/widgets/panelCard.dart';
import 'package:url_launcher/url_launcher.dart';

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
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 35.0,
          ),
        ),
        title: Text(
          'Contact Us',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: volunteersData.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                launch("tel://${volunteersData[index].phoneNumber}");
              },
              child: PanelCard(
                volunteerModel: volunteersData[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
