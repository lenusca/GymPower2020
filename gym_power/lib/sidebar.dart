
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_power/TabClass.dart';
import 'package:gym_power/TabWorkout.dart';
import 'package:gym_power/map.dart';
import 'package:gym_power/payment.dart';

import 'package:gym_power/service/auth.dart';
import 'package:gym_power/settings.dart';
import 'package:gym_power/signin.dart';


import 'TabHealth.dart';


class SideBar extends StatelessWidget {
  final String nome;
  final int numSocio;
  final String img;
  final AuthService _auth = AuthService();

  SideBar({this.nome, this.numSocio, this.img});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        child: ListView(

          children: <Widget>[
            //nome e imagem do utilizador
            UserAccountsDrawerHeader(

              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(img),
                backgroundColor: Colors.transparent,
                radius: 400.0,
              ),
              accountName: new Text(nome, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),),
              accountEmail: new Text("Member number: ${numSocio}", style: new TextStyle(fontSize: 17.0)),
              decoration: new BoxDecoration(color: Colors.deepOrange[300]),
            ),

            //opcoes do menu
            //workout
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(TabWorkout.tag);
              },
              child: ListTile(
                leading: Icon(Icons.fitness_center, color: Colors.black, size: 35.0,),
                title:  Text("Workout Plan", style: new TextStyle(fontSize: 20.0),)
              ),

            ),

            //class map
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(TabClass.tag);
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.users, color: Colors.black, size: 32.0,),
                title: Text("Class Map", style: new TextStyle(fontSize: 20.0),),
              ),
            ),

            //Health
            InkWell(
              onTap: (){
               Navigator.of(context).pushNamed(TabHealth.tag);
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.heartbeat, color: Colors.black, size: 35.0,),
                title: Text("Health", style: new TextStyle(fontSize: 20.0),),
              ),
            ),

            //Progress
            InkWell(
              onTap: (){
                //Navigator.of(context).pushNamed(TabActivities.tag);
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.calendarCheck, color: Colors.black, size: 35.0,),
                title: Text("My Activities", style: new TextStyle(fontSize: 20.0),),
              ),
            ),
            //QR Code Camera

            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(Settings.tag);
              },

              child: ListTile(
                leading: Icon(Icons.settings, color: Colors.black,size: 35.0,),
                title: Text("Settings", style: new TextStyle(fontSize: 20.0)),
              ),
            ),

            //GPS
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(gpsMap.tag);
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.mapMarkerAlt, color: Colors.black,size: 35.0,),
                title: Text("Localization", style: new TextStyle(fontSize: 20.0)),
              ),
            ),

            //Payment
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(Payment.tag);
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.wallet, color: Colors.black,size: 35.0,),
                title: Text("Payment", style: new TextStyle(fontSize: 20.0)),
              ),
            ),

            //Logout
            InkWell(
              onTap: () async {
                await _auth.signOut();
                Navigator.of(context).pushReplacementNamed(SignIn.tag);
              },
              child: ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.black,size: 35.0,),
                title: Text("Logout", style: new TextStyle(fontSize: 20.0, color: Colors.black)),
              ),

            )
          ],
        ),
    );
  }
}