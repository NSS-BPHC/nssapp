import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/views/screens/auth/authenticationScreen.dart';
import 'package:nssapp/views/screens/home/homeScreen.dart';
import 'package:provider/provider.dart';

/// Shows Log in screen or the Home page depending on the log in state
class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return (context.watch<LoginManager>().isLoggedIn)
        ? HomeScreen()
        : AuthenticationScreen();
  }
}
