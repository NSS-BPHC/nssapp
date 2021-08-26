import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/home/homeScreen.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

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
                  SizedBox(height: 20),
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: TextField(
                      controller: emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: TextField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your password',
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  _handleSubmit(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
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
                          // SizedBox(
                          //   height: 20.0,
                          //   child: SvgPicture.asset('assets/images/google.svg'),
                          // ),
                          (context.watch<LoginManager>().isLoading)
                              ? CircularProgressIndicator()
                              : Text(
                                  'Log in',
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

  void _handleSubmit(BuildContext context) {
    Provider.of<LoginManager>(context, listen: false)
        .login(email: "test@test.com", password: "123456");
    // .login(email: "nssbphctech@gmail.com", password: 'nsstech@2021');
    // Navigator.pop(context);
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
