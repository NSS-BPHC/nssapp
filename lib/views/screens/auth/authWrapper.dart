import 'package:flutter/material.dart';
import 'package:nssapp/views/screens/auth/authenticationScreen.dart';
import 'package:nssapp/views/screens/home/homeScreen.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return (1 == 1) ? AuthenticationScreen() : HomeScreen();
  }
}
