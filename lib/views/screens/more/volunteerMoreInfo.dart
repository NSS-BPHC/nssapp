import 'package:flutter/material.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/more/volunteerAboutUs.dart';
import 'package:nssapp/views/screens/more/volunteerContactUs.dart';
import 'package:nssapp/views/screens/more/volunteerDropSuggestions.dart';

class VolunteerMoreInfoScreen extends StatefulWidget {
  const VolunteerMoreInfoScreen({Key? key}) : super(key: key);

  @override
  _VolunteerMoreInfoScreenState createState() =>
      _VolunteerMoreInfoScreenState();
}

class _VolunteerMoreInfoScreenState extends State<VolunteerMoreInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: AppTheme.screenPadding,
          child: Column(
            children: [
              SizedBox(height: 80.0),
              Column(
                children: [
                  Center(
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Image(
                        image: AssetImage('assets/images/NSS-symbol.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'NOT ME BUT YOU!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 80.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VolunteerAboutUsScreen()));
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'About Us',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          width: 160,
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VolunteerContactUs(),
                    ),
                  );
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Contact Us',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VolunteerDropSuggestionsScreen(),
                    ),
                  );
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Drop Suggestions',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
