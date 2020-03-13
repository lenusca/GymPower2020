import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/service/auth.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HealthTable extends StatefulWidget{
  @override
  HealthTableState createState() => new HealthTableState();
}
class HealthTableState extends State<HealthTable> {
  final AuthService _auth = AuthService();
  bool loading = false;
  bool healthFlag = false;
  final List<DateTime> data = [];
  String _currentDate, _currentDate2;


  @override
  Widget build(BuildContext context) {
    // para ir buscar o uid do utilizador que fez login
    User user = Provider.of<User>(context);
    dataDropDown(documents){
      List<String> data = [];
      for(int i=0; i < documents.length; i++){

        data.add(DateFormat("dd-MM-yyyy").format(documents[i]['data'].toDate()).toString());
      }
      return DropdownButton(
          value: _currentDate,
          items: data.map((v){
            return DropdownMenuItem(
                value: v,
                child: Text('$v'),
          );
        }).toList(),
        onChanged: (val) => setState(() => _currentDate = val),
      );
    }

    dataDropDown2(documents){
      List<String> data = [];
      for(int i=0; i < documents.length; i++){

        data.add(DateFormat("dd-MM-yyyy").format(documents[i]['data'].toDate()).toString());
      }
      return DropdownButton(
        value: _currentDate2,
        items: data.map((v){
          return DropdownMenuItem(
            value: v,
            child: Text('$v'),
          );
        }).toList(),
        onChanged: (val) => setState(() => _currentDate2 = val),
      );
    }

    healthTable(documents) {
      String imc = '', musclemass= '', nivelagua= '', gorduravisceral= '', peso= '', altura= '';
      String imc2 = '', musclemass2= '', nivelagua2= '', gorduravisceral2= '', peso2= '', altura2= '';
      for(int i=0; i < documents.length; i++){
        if(_currentDate == DateFormat("dd-MM-yyyy").format(documents[i]['data'].toDate()).toString()){
          imc = documents[i]['IMC'].toString();
          musclemass = documents[i]['massaMuscular'].toString();
          nivelagua = documents[i]['nivelAgua'].toString();
          gorduravisceral = documents[i]['gorduraVisceral'].toString();
          peso = documents[i]['peso'].toString();
          altura = documents[i]['altura'].toString();
        }
        if(_currentDate2 == DateFormat("dd-MM-yyyy").format(documents[i]['data'].toDate()).toString()){
          imc2 = documents[i]['IMC'].toString();
          musclemass2 = documents[i]['massaMuscular'].toString();
          nivelagua2 = documents[i]['nivelAgua'].toString();
          gorduravisceral2 = documents[i]['gorduraVisceral'].toString();
          peso2 = documents[i]['peso'].toString();
          altura2 = documents[i]['altura'].toString();
        }
      }
      return DataTable(
        
          columns: [

            DataColumn(label: Text('PARAMETER', style: TextStyle(color: Colors.deepOrangeAccent[200], fontWeight: FontWeight.bold, fontSize: 15.0),)),
            DataColumn(label: Text('BEGIN', style: TextStyle(color: Colors.deepOrangeAccent[200], fontWeight: FontWeight.bold, fontSize: 15.0),)),
            DataColumn(label: Text('END', style: TextStyle(color: Colors.deepOrangeAccent[200], fontWeight: FontWeight.bold, fontSize: 15.0),)),
            //DataColumn(label: Text('END')),
          ],
          rows: [
            // Body Fat
            DataRow(cells: [
              DataCell(Text("IMC(%)")),
              DataCell(Text(imc)),
              DataCell(Text(imc2)),
            ]),

            // Muscle Mass
            DataRow(cells: [
              DataCell(Text("Muscle Mass(Kg)")),
              DataCell(Text(musclemass)),
              DataCell(Text(musclemass2)),

            ]),

            // Water
            DataRow(cells: [
              DataCell(Text("Water(%)")),
              DataCell(Text(nivelagua)),
              DataCell(Text(nivelagua2)),
              //value
            ]),

            // Visceral Fat Level
            DataRow(cells: [
              DataCell(Text("Visceral Fat Level")),
              DataCell(Text(gorduravisceral)),
              DataCell(Text(gorduravisceral2)),
            ]),

            // Weight
            DataRow(cells: [
              DataCell(Text("Weight(Kg)")),
              DataCell(Text(peso)),
              DataCell(Text(peso2)),
              //value
            ]),

            // Height
            DataRow(cells: [
              DataCell(Text("Height(cm)")),
              DataCell(Text(altura)),
              DataCell(Text(altura2)),

            ]),
          ]
      );
    }

    return  Scaffold(
          body: StreamBuilder(
              stream: Firestore.instance.collection('planoSaude').where('userID', isEqualTo: user.uid).snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Loading();
                }
                else{
                  return ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(20, 25, 0, 20),

                            child: Row(
                              children: <Widget>[
                                Text('BEGIN: '),
                                dataDropDown(snapshot.data.documents)
                              ],
                            ),
                          ),

                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(30, 25, 0, 20),

                            child: Row(
                              children: <Widget>[
                                Text('END: '),
                                dataDropDown2(snapshot.data.documents)
                              ],
                            ),
                          ),
                        ],
                      ),


                      healthTable(snapshot.data.documents),
                    ],
                  );
                }
              })

    );
  }



}

