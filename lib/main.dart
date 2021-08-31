import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nssapp/services/getApi.dart';
import 'package:nssapp/utilities/size_config.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/auth/authWrapper.dart';
import 'package:provider/provider.dart';

import 'models/loginManager.dart';

void main() async {
  // App starts here
  WidgetsFlutterBinding.ensureInitialized();

  // LoginManager handles login and logout
  // by the Provider package
  LoginManager loginManager = new LoginManager();
  // Checks if user had logged in previously (to avoid log in every time
  // the app is opened)
  await loginManager.init();
  runApp(MyApp(loginManager));
}

class MyApp extends StatefulWidget {
  final LoginManager loginManager;
  const MyApp(this.loginManager);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return LayoutBuilder(builder: (context, constraints) {
      SizeConfig().init(constraints);
      return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: widget.loginManager),
          ChangeNotifierProvider(create: (_) => GetAPIProvider())
        ],
        builder: (_, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: AuthWrapper(),

          // home: ChangeNotifierProvider.value(
          //   value: widget.loginManager,
          //   builder: (context, _) => AuthWrapper(),
          // ),
        ),
      );
    });
  }
}
