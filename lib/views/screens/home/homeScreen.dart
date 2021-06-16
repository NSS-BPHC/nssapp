import 'package:flutter/material.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/merchandise/merchandiseScreen.dart';
import 'package:nssapp/views/screens/dashboard/volunteerDashBoard.dart';
import 'package:nssapp/views/screens/events/allEventsScreen.dart';
import 'package:nssapp/views/screens/more/volunteerMoreInfo.dart';
import 'package:nssapp/views/screens/profile/volunteerProfile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 2;
  int index = 0;
  List<Widget> widgetOptions = <Widget>[
    AllEventsScreen(),
    MerchandiseScreen(),
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
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        selectedItemColor: AppTheme.secondaryColor,
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
    );
  }
}
