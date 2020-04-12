import 'package:flutter/material.dart';
import 'package:gym_power/models/user.dart';
import 'package:provider/provider.dart';
import 'package:gym_power/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutEasy extends StatefulWidget {
  final userID;

  WorkoutEasy({Key key, this.userID}) : super(key: key);

  @override
  _WorkoutEasyState createState() => _WorkoutEasyState();
}

class _WorkoutEasyState extends State<WorkoutEasy> {

  String img;
  int inclination, nSerie, repetition, time;
  String name = "";
  double weight = 0, velocity = 0;
  String qrCode = "";


  @override
  List<Container> workout = [];
  getData(data) {
   for(int i = 0; i<data.length; i++){
     Firestore.instance.document(data[i].path).get().then((DocumentSnapshot doc){
       print(doc.data['nome']);
       workout.add(Container(
         child: Text(doc.data['nome']),
       ));
     });
   }


  }

  Widget build(BuildContext context) {

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('planoTreino')
                .where('userID', isEqualTo: widget.userID)
                .where('nivel', isEqualTo: 'easy').snapshots(),
            builder: (context, snapshot){

              if(!snapshot.hasData){

                return Loading();
              }
              else{
                print(workout.length);
                print(snapshot.data.documents[0].data['nivel']);
                getData(snapshot.data.documents[0].data['exercicios']);
                return ListView.builder(
                  itemCount: workout.length,
                  itemBuilder: (BuildContext context, int index){
                    return workout[index];
                  },

                );
              }
            })
    );

  }


}