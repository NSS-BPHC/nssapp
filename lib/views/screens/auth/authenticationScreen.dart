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
                    width: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      color: AppTheme.tertiaryColor,
                      border: Border.all(color: AppTheme.textBlackColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/google.svg'),
                          SizedBox(width: 10.0),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: AppTheme.textBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
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
