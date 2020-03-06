import 'package:flutter/material.dart';
import 'package:gym_power/SignUp.dart';
import 'package:gym_power/TabHealth.dart';
import 'package:gym_power/healthTable.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/service/auth.dart';
import 'package:gym_power/settings.dart';
import 'package:gym_power/signin.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MultiProvider(
    child:MyApp());
    );



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final routes = <String, WidgetBuilder>{
    SignIn.tag: (context) => SignIn(),
    SignUp.tag: (context) => SignUp(),
    Home.tag: (context) => Home(),
    Settings.tag: (context) => Settings(),
    TabHealth.tag: (context) => TabHealth()
  };

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Gym Power",
        theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
        home: SignIn(),
        routes: routes,
      ),

    );
  }
}

