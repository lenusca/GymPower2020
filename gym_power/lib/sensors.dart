
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SensorsData extends StatefulWidget {
  @override
  _SensorsDataState createState() => _SensorsDataState();
}

class _SensorsDataState extends State<SensorsData> {
  String passos = "";
  String _km = "Unknown";
  String _calories = "Unknow";
  String _stepCountValues = "Unknow";
  StreamSubscription<int> _subscription;
  double _cntSteps; //step count
  double _cntKM; // km count
  double _convert;

  @override
  void initState(){
    super.initState();
    setUpPedometer();

  }

  void setUpPedometer(){
    Pedometer pedometer = new Pedometer();
    _subscription = pedometer.pedometerStream.listen(_onData, onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onDone(){}

  void _onError(error){
    print("ERROR: $error");
  }

  void _onData(int stepCount) async {
      print(stepCount);
      setState(() {
        _stepCountValues = "$stepCount";
        print(_stepCountValues);
      });

      var distance = stepCount;
      double y = (distance + .0); // convert int in double

      setState(() {
        _cntSteps = y; // nnumber of steps
      });

      // we remove some decimals
    var long3 = (_cntSteps / 100);
    long3 = num.parse(y.toStringAsFixed(3));
    var long4 = (long3/1000);
    getDistanceRun(_cntSteps);
    setState(() {
      _convert = long4;
    });
  }

  // calculate distance
  void getDistanceRun(double _cntSteps){
    var distance = ((_cntSteps * 78)/100000);
    distance = num.parse(distance.toStringAsFixed(2));
    setState(() {
      _km = "$distance";
      print(_km);
    });
    setState(() {
      _cntKM = distance * 30;
    });
  }

  // calculate calories burned in km using number of steps
  void getCalories(){
    setState(() {
      var calories = _cntKM;
      _calories = "$calories";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white24,
      child: ListView(
        padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0,),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0),
            width: 200,
            height: 200,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(27.0),
                bottomRight: Radius.circular(27.0),
                topLeft: Radius.circular(27.0),
                topRight: Radius.circular(27.0),
              )
            ),
            child: CircularPercentIndicator(
                radius: 150.0,
                lineWidth: 13.0,
                animation: true,
                center: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Icon(
                        FontAwesomeIcons.walking,
                        size: 30.0,
                        color: Colors.deepOrangeAccent,
                      ),

                    ),
                    Container(
                      child: Text('$_stepCountValues steps' ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.deepOrangeAccent
                      ),),
                    ),
                  ],
                ),
              percent: _convert,
              footer: Text(
                  'Number of steps $_stepCountValues',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.white
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.deepOrangeAccent,
            ),
          ),
          Divider(
            height: 10,
          ),
          /*Container(
            padding: EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10.0),
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                Container(
                  child: Card(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: null,
                            fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    child: Text(
                      "$_km Km",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    ),
                    color: Colors.white54,
                  ),
                ),
                VerticalDivider(
                  width: 20.0,
                ),
                Container(
                  child: Card(
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: null,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter
                        ),
                      ),
                    ),
                    color: Colors.transparent,
                  ),
                ),
                VerticalDivider(
                  width: 20,
                ),
                Container(
                  child: Card(
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: null,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter
                        ),
                      ),
                    ),
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
          ),
          Container(
            padding: EdgeInsets.only(top: 2.0),
            width: 150,
            height: 30,
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Card(
                    child: Container(
                      child: Text(
                        "$_km Km",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                  ),

                ),
                VerticalDivider(width: 20.0,),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Card(
                    child: Container(
                      child: Text(
                        "$_calories kCal",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 20.0,),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Card(
                    child: Container(
                      child: Text(
                        "$_stepCountValues Steps",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                  ),
                ),*/
              //],
            //),
          //),
        ],
      ),
    );
  }
}
