import 'package:flutter/material.dart';
import 'package:nssapp/views/screens/volunteerDashBoard.dart';
import 'package:nssapp/views/screens/volunteerEventsScreen.dart';
import 'package:nssapp/views/screens/volunteerMerchandise.dart';
import 'package:nssapp/views/screens/volunteerMoreInfo.dart';
import 'package:nssapp/views/screens/volunteerProfile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 2;
  List<Widget> widgetOptions = <Widget>[
    VolunteerEventsScreen(),
    VolunteerMerchandiseScreen(),
    VolunteerDashBoardScreen(),
    VolunteerProfileScreen(),
    VolunteerMoreInfoScreen(),
  ];
  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0XFF091A44),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0,
          onTap: onTabTapped,
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Merchandise',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
