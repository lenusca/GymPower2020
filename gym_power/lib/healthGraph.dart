import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/user.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HealthGraph extends StatefulWidget{
  @override
  HealthGraphState createState() => new HealthGraphState();
}
class HealthGraphState extends State<HealthGraph> {
  bool loading = false;
  bool healthFlag = false;



  @override
  Widget build(BuildContext context) {
    // para ir buscar o uid do utilizador que fez login
    User user = Provider.of<User>(context);

    DrawGraph(documents, String s) {

      final List<LinearValues> data = [];
      for(int i = 0; i < documents.length; i++){
        data.add(LinearValues(documents[i].data['data'].toDate(), documents[i].data[s].toInt()));
      }

      final List<charts.Series<LinearValues, DateTime>> seriesList = [charts.Series<LinearValues, DateTime>(
        id: s,
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (LinearValues values, _) => values.d,
        measureFn: (LinearValues values, _) => values.value,
        data: data,
      )];

      return charts.TimeSeriesChart(

        seriesList,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(),
      );
    }

    return  Scaffold(

        body: StreamBuilder(
            stream: Firestore.instance.collection('planoSaude').where('userID', isEqualTo: user.uid).orderBy('data', descending: false).snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Loading();
              }
              else{
                return DefaultTabController(
                    length: 4,
                    child: Scaffold(
                      appBar: TabBar(
                        isScrollable: true,
                        indicatorWeight: 2.0,
                        indicatorColor: Colors.deepOrangeAccent[200],
                        tabs: <Widget>[
                          Tab(child: Text("IMC", style: TextStyle(color: Colors.deepOrangeAccent[200], fontSize: 13),),),
                          Tab(child: Text("MUSCLE MASS", style: TextStyle(color: Colors.deepOrangeAccent[200], fontSize: 13),),),
                          Tab(child: Text("VISCERAL", style: TextStyle(color: Colors.deepOrangeAccent[200], fontSize: 13),),),
                          Tab(child: Text("WEIGHT", style: TextStyle(color: Colors.deepOrangeAccent[200], fontSize: 13),),),
                        ],
                      ),
                      body: TabBarView(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 0, 20),
                              child: DrawGraph(snapshot.data.documents, "IMC"),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 0, 20),
                              child: DrawGraph(snapshot.data.documents, "massaMuscular"),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 0, 20),
                              child: DrawGraph(snapshot.data.documents, "gorduraVisceral"),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 0, 20),
                              child: DrawGraph(snapshot.data.documents, "peso"),
                            ),

                          ]
                      ),
                    ),
                );
              }
            })

    );
  }



}
// Sammple linear data type
class LinearValues{

  final DateTime d;
  final int value;

  LinearValues(this.d, this.value);

}


