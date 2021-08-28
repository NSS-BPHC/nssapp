import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/services/routes.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/home/homeScreen.dart';
import 'package:provider/provider.dart';

enum LoadState { done, loading, nothing }

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  LoadState sentEmail = LoadState.nothing;
  String? message;
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
                  if (message != null)
                    Text(message ?? "Error",
                        style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      _handleForgotPassword(
                        context,
                        emailTextController.text,
                      );
                    },
                    child: Text(
                      sentEmail == LoadState.done
                          ? "Check your inbox for the reset link"
                          : sentEmail == LoadState.loading
                              ? "Sending email..."
                              : "Forgot password",
                      style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: sentEmail == LoadState.done
                              ? Colors.green
                              : Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      _handleGuest(context);
                    },
                    child: Text(
                      "Log in as guest instead",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  _handleSubmit(
                    context,
                    email: emailTextController.text,
                    password: passwordTextController.text,
                  );
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
                      padding: const EdgeInsets.only(
                        bottom: 10.0,
                        right: 12,
                        left: 12,
                        top: 12,
                      ),
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
                                    fontSize: 17.0,
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

  Future<void> _handleForgotPassword(
      BuildContext context, String? email) async {
    if ((email ?? "").isEmpty) {
      setState(() {
        message = "Enter your email";
      });
      return;
    }
    if (sentEmail == LoadState.loading) return;
    setState(() {
      sentEmail = LoadState.loading;
      message = null;
    });
    final response =
        await post(Uri.parse("$BASE_URL/users/forgot-password"), body: {
      email: email,
    });
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      setState(() {
        sentEmail = LoadState.done;
        message = null;
      });
    } else {
      setState(() {
        sentEmail = LoadState.nothing;
        message = "Invalid email";
      });
    }
  }

  void _handleGuest(BuildContext context) {
    context.read<LoginManager>().anonymousLogin();
  }

  void _handleSubmit(BuildContext context, {String? email, String? password}) {
    setState(() {
      message = null;
    });
    if (context.read<LoginManager>().isLoading) {
      print("Wait");
      return;
    }
    // print("Asd");
    // return;
    final regex = RegExp(
        r"(f20[12]\d{5}@hyderabad.bits-pilani.ac.in)|(test@test\.com)|(nsstech@gmail.com)");
    if ((email ?? '').isEmpty ||
        (password ?? '').isEmpty ||
        !regex.hasMatch(email ?? "a")) {
      print("here");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter valid email and password")),
      );
      setState(() {
        message = "Enter valid email and password";
      });
      return;
    }

    Provider.of<LoginManager>(context, listen: false)
        .login(email: email ?? 'a', password: password ?? 'a')
        .then((value) {
      if (!value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Incorrect email or password")));
        setState(() {
          message = "Incorrect email or password";
        });
      } else
        setState(() {
          message = null;
        });
    });
    // .login(email: "nssbphctech@gmail.com", password: 'nsstech@2021');
    // Navigator.pop(context);
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
