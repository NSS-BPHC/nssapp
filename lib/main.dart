import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nssapp/utilities/size_config.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/auth/authWrapper.dart';
import 'package:provider/provider.dart';

import 'models/loginManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LoginManager loginManager = new LoginManager();
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
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          // home: AuthWrapper(),
          home: ChangeNotifierProvider.value(
            value: widget.loginManager,
            builder: (context, _) => AuthWrapper(),
          ));
    });
  }
}
