import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_power/TabHealth.dart';
import 'package:gym_power/healthTable.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/service/auth.dart';
import 'package:gym_power/service/database.dart';
import 'package:gym_power/settings.dart';
import 'package:gym_power/sidebar.dart';
import 'package:gym_power/signin.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class Home extends StatefulWidget {
  static String tag = "home";
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    //logout
    final exitLabel = FlatButton(
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.fromLTRB(230, 0, 0, 0),
        child: Row(
          children: <Widget>[
            new Icon(
              Icons.exit_to_app,
              color: Colors.black,
              size: 20.0,
            ),
            new Text("Logout", style: TextStyle(color: Colors.black, fontSize: 15.0, ),),
          ],
        ),
      ),
      onPressed: () async {
        await _auth.signOut();
        Navigator.of(context).pushReplacementNamed(SignIn.tag);
      },
    );

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor : Colors.transparent,
        radius: 100.0, //tamanho da imagem
        child: Image.asset("assets/logo.png"),
      ),
    );

    return  Container(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: StaggeredGridView.count(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0, //ao lado
                  mainAxisSpacing: 15.0, //por baixo
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  children: <Widget>[

                    Container(
                      padding:EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: logo,
                    ),
                    // workout plan
                    Card(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: Colors.deepOrangeAccent[200],

                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(Settings.tag);
                        },
                        splashColor: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.fitness_center, size: 60.0, ),
                              Text("Workout Plan", style: new TextStyle(fontSize: 17.0, color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ),
                    // class map
                    Card(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: Colors.deepOrangeAccent[200],

                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(Settings.tag);
                        },
                        splashColor: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.users, size: 60.0, ),
                              Text("Class Map", style: new TextStyle(fontSize: 17.0, color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Health
                    Card(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: Colors.deepOrangeAccent[200],
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(TabHealth.tag);
                        },
                        splashColor: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.heartbeat, size: 60.0, ),
                              Text("Health", style: new TextStyle(fontSize: 17.0, color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ),

                    //My Activities
                    Card(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: Colors.deepOrangeAccent[200],
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(Settings.tag);
                        },
                        splashColor: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.calendarCheck, size: 60.0, ),
                              Text("My Activities", style: new TextStyle(fontSize: 17.0, color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Settings
                    Card(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: Colors.deepOrangeAccent[200],
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(Settings.tag);
                        },
                        splashColor: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.settings, size: 60.0, ),
                              Text("Settings", style: new TextStyle(fontSize: 17.0, color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Settings
                    Card(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: Colors.deepOrangeAccent[200],
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(Settings.tag);
                        },
                        splashColor: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.mapMarkerAlt, size: 60.0, ),
                              Text("Localization", style: new TextStyle(fontSize: 17.0, color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ),
                    //logout
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: exitLabel,
                    ),
                  ],
                  staggeredTiles: [
                    StaggeredTile.fit(2),
                    StaggeredTile.extent(1, 100.0),
                    StaggeredTile.extent(1, 100.0),
                    StaggeredTile.extent(1, 100.0),
                    StaggeredTile.extent(1, 100.0),
                    StaggeredTile.extent(1, 100.0),
                    StaggeredTile.extent(1, 100.0),
                    StaggeredTile.fit(2),

                  ],

                ),


              ),
            );


  }
}