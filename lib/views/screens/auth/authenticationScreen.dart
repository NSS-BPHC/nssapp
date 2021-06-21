import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/home/homeScreen.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      'NSS BPHC',
                      style: TextStyle(
                        color: AppTheme.textBlackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    width: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      color: AppTheme.tertiaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.tertiaryColor,
                          offset: const Offset(3.0, 3.0),
                          blurRadius: 2.0,
                          spreadRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.0,
                            child: SvgPicture.asset('assets/images/google.svg'),
                          ),
                          Text(
                            'Sign in',
                            style: TextStyle(
                              color: AppTheme.textBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
