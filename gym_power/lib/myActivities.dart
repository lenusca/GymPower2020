
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:gym_power/home.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/sidebar.dart';
import 'package:provider/provider.dart';

import 'package:gym_power/models/user.dart';



class MyActivities extends StatefulWidget{
  static String tag = "MyActivities";

  @override
  MyActivitiesState createState() => new MyActivitiesState();
}


class MyActivitiesState extends State<MyActivities>{

  final List<Card> aulasFreqCards = [];
  final List<Card> workoutCards = [];
  
  fillCardList(data, String userID) async{
    aulasFreqCards.clear();
    workoutCards.clear();
    //Fill workout
    var workoutFeito = data['workout'];
    for(int i =0; i < data['workout'].length; i++)
    {
      workoutCards.add(Card(
         semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Container(
          height: 130,
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 130,
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child:  Text("Workout", style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500), textAlign: TextAlign.left, ),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerRight,
                        child: Text("NºSeries", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        alignment: Alignment.centerRight,
                        child: Text("Intensity", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 145,
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child:  Text(data['workout'][i]["nome"], style: TextStyle(color: Colors.deepOrangeAccent[200], fontSize: 20.0, fontWeight: FontWeight.w500), textAlign: TextAlign.left, ),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        alignment: Alignment.centerRight,
                        color: Colors.white,
                        child: Text(data['workout'][i]["nSerie"].toString(), style: TextStyle(color: Colors.deepOrangeAccent[200], fontWeight: FontWeight.w500,fontSize: 20.0),),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                        alignment: Alignment.centerRight,
                        color: Colors.white,
                        child: Text(data['workout'][i]["intensity"], style: TextStyle(color: Colors.deepOrangeAccent[200], fontWeight: FontWeight.w500,fontSize: 20.0),),
                      ),
                    ],
                  ),


                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    //color: Colors.black,
                    child: IconButton(
                      color: Colors.black,
                      icon: Icon(FontAwesomeIcons.trash, color: Colors.grey, ),
                      onPressed: (){
                        workoutFeito.removeAt(i);

                        Firestore.instance.collection('users')
                            .document(userID).updateData({
                          'workout': workoutFeito
                        })
                            .catchError((e) {
                          print(e);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }
    //Fill aulas freq
    var aulasInscritas = data['aulasFrequentadas'];

    for(int i =0; i < data['aulasFrequentadas'].length; i++)
    {
      aulasFreqCards.add(Card(
         semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Container(
          height: 130,
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    Row(
                      children: <Widget>[
                        Container(
                          width: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child:  Text("Class Name", style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500), textAlign: TextAlign.left, ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          alignment: Alignment.centerRight,
                          child: Text("Start", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(60, 0, 0, 0),
                          alignment: Alignment.centerRight,
                          child: Text("Finish", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 90,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child:  Text(data['aulasFrequentadas'][i]["nome"], style: TextStyle(color: Colors.deepOrangeAccent[200], fontSize: 20.0, fontWeight: FontWeight.w500), textAlign: TextAlign.left, ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerRight,
                          color: Colors.white,
                          child: Text(data['aulasFrequentadas'][i]["horaInicio"], style: TextStyle(color: Colors.deepOrangeAccent[200],fontSize: 20.0, fontWeight: FontWeight.w500),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                          alignment: Alignment.centerRight,
                          color: Colors.white,
                          child: Text(data['aulasFrequentadas'][i]["horaFim"], style: TextStyle(color: Colors.deepOrangeAccent[200], fontSize: 20.0,fontWeight: FontWeight.w500),),
                        ),
                      ],
                    ),
                  ],
                ),
              Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(20, 40, 0, 0),
                  //color: Colors.black,
                  child: IconButton(
                    color: Colors.black,
                    icon: Icon(FontAwesomeIcons.trash, color: Colors.grey, ),
                    onPressed: (){
                      aulasInscritas.removeAt(i);
                      print(aulasInscritas);
                      Firestore.instance.collection('users')
                          .document(userID).updateData({
                        'aulasFrequentadas': aulasInscritas
                      })
                          .catchError((e) {
                        print(e);
                      });
                    },
                  ),
                ),
              ],
            ),
        ],
          ),)
      ));
    }}



  allWorkouts(){
    return ListView.builder(
        itemCount: workoutCards.length,

        itemBuilder: (BuildContext context, int index){
          return workoutCards[index];
        }
    );
  }

  allClasses(){
    return ListView.builder(
      itemCount: aulasFreqCards.length,
      itemBuilder: (BuildContext context, int index){
        return aulasFreqCards[index];
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder(
      stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
      builder: (context, snapshot)
      {

        if(snapshot.hasData)
        {

          fillCardList(snapshot.data, user.uid);

          return DefaultTabController(
            length: 2,

            child: new Scaffold(

              appBar: AppBar(
                title: Text("My Activities", style: TextStyle(color: Colors.white, fontSize: 25)),
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
                  indicatorWeight: 2.0,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(child: Container(
                      child: Text("CLASSES", style: TextStyle(color: Colors.white, fontSize: 16),),),
                    ),
                    Tab(child: Container(
                      child: Text("WORKOUTS", style: TextStyle(color: Colors.white, fontSize: 16),),),
                    ),

                  ],
                ),
          ),
              drawer: SideBar(nome: snapshot.data['nome'], numSocio: snapshot.data['numSocio'], img: snapshot.data['img'],),

              body: TabBarView(
                children:  [
                      allClasses(),
                      allWorkouts(),
                    ],
                  ),
                ),
              );
        }
        else{
          return Loading();
        }
      }
    );    
  }
}


