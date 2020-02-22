import 'package:flutter/material.dart';
import 'package:gym_power/SignUp.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/service/auth.dart';
import 'package:gym_power/signin.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final routes = <String, WidgetBuilder>{
    SignIn.tag: (context) => SignIn(),
    SignUp.tag: (context) => SignUp(),
    Home.tag: (context) => Home(),
  };

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Gym Power",
        theme: ThemeData(
        ),
        darkTheme: ThemeData.dark(),
        home: SignIn(),
        routes: routes,
      ),

    );
  }
}

