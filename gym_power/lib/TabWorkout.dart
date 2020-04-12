import 'package:flutter/material.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_power/sidebar.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/workout/countDownTimer.dart';
import 'package:provider/provider.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/workout/workoutEasy.dart';
import 'package:gym_power/workout/workoutMedium.dart';
import 'package:gym_power/workout/workoutHard.dart';

class TabWorkout extends StatefulWidget {
  static String tag = "tabWorkout";
  @override
  TabWorkoutState createState() => new TabWorkoutState();
}

class TabWorkoutState extends State<TabWorkout> {
  
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot){
          if(snapshot.hasData){
          UserData userData = snapshot.data;
          return  DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Workout Plan", style: TextStyle(color: Colors.white, fontSize: 25)),
                backgroundColor: Colors.deepOrangeAccent[200],
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.home),
                      color: Colors.white,
                      onPressed:(){
                        Navigator.of(context).pushNamed(Home.tag);
                      }
                  )
                ],
                bottom: TabBar(
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 40.0),
                  indicatorWeight: 2.0,
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    Tab(child: Text("EASY", style: TextStyle(color: Colors.white, fontSize: 15),),),
                    Tab(child: Text("MEDIUM", style: TextStyle(color: Colors.white, fontSize: 15),),),
                    Tab(child: Text("HARD", style: TextStyle(color: Colors.white, fontSize: 15),),),
                  ],
                ),
              ),
              drawer: SideBar(nome: userData.nome, numSocio: userData.numSocio, img: userData.img,),
              body: TabBarView(
                children: <Widget>[
                  WorkoutEasy(),
                  WorkoutMedium(),
                  WorkoutHard(),
                ],
              ),
            ),
          );
          }
          else {
            return Loading();
          }
        },
    );
  }
}
