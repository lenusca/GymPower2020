import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/health.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/service/auth.dart';
import 'package:gym_power/service/database.dart';
import 'package:provider/provider.dart';

class HealthTable extends StatefulWidget{
  final uid;
  HealthTable({this.uid});
  @override
  HealthTableState createState() => new HealthTableState();
}
class HealthTableState extends State<HealthTable> {
  final AuthService _auth = AuthService();
  bool loading = false;
  bool healthFlag = false;
  var health;

  @override
  void initState(){
    super.initState();
    DatabaseService().getHealth(HealthTable().uid).then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty){
        healthFlag = true;
        health = docs.documents[0].data;
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    // para ir buscar o uid do utilizador que fez login
    return StreamBuilder<HealthData>(
        stream: DatabaseService(uid: HealthTable().uid).healthData,
        builder: (context, snapshot){
          if(snapshot.hasData){
            HealthData userData = snapshot.data;
            print("AQUIII"+userData.altura.toString());
            return Scaffold(
              body:  Container(
                alignment: Alignment.center,

                child:DataTable(
                    columns: [
                      DataColumn(label: Text('Parameter')),
                      DataColumn(label: Text('Values')),
                      //DataColumn(label: Text('END')),
                    ],
                    rows: [
                      // Body Fat
                      DataRow(cells: [
                        DataCell(Text("Body Fat(%)")),
                        DataCell(Text(userData.altura.toString())),
                      ]),

                      // Muscle Mass
                      DataRow(cells: [
                        DataCell(Text("Muscle Mass(Kg)")),
                        DataCell(Text("Weight(Kg)"), showEditIcon: true),

                      ]),

                      // Water
                      DataRow(cells: [
                        DataCell(Text("Water(%)")),
                        DataCell(Text("Weight(Kg)"), showEditIcon: true),
                        //value
                      ]),

                      // Visceral Fat Level
                      DataRow(cells: [
                        DataCell(Text("Visceral Fat Level")),
                        DataCell(Text("Weight(Kg)"), showEditIcon: true),
                      ]),

                      // Weight
                      DataRow(cells: [
                        DataCell(Text("Weight(Kg)")),
                        DataCell(Text("Weight(Kg)"), showEditIcon: true),
                        //value
                      ]),

                      // Height
                      DataRow(cells: [
                        DataCell(Text("Height(cm)")),
                        DataCell(Text("Weight(Kg)"), showEditIcon: true),

                      ]),
                    ]
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