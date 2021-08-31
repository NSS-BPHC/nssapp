import 'package:flutter/material.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/more/volunteerAboutUs.dart';
import 'package:nssapp/views/screens/more/volunteerContactUs.dart';
import 'package:nssapp/views/screens/more/volunteerDropSuggestions.dart';
import 'package:provider/provider.dart';

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
                    child: Hero(
                      tag: "logo",
                      child: Container(
                        height: 150,
                        width: 150,
                        child: Image(
                          image: AssetImage('assets/images/NSS-symbol.png'),
                        ),
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
              LogOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class LogOutButton extends StatefulWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  _LogOutButtonState createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<LogOutButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final isVisitor = context.watch<LoginManager>().isVisitor;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                this.loading = true;
              });
              Provider.of<LoginManager>(context, listen: false).logOut();
              print("logging out");
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 12.0),
                child: Text(
                  loading
                      ? "Loading..."
                      : isVisitor
                          ? "Log in"
                          : "Log Out",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Colors.white,
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
