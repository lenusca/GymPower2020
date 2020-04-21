
import 'dart:async';
import 'dart:math';
import 'package:conreality_pulse/conreality_pulse.dart';
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
  String _calories = "Unknown";
  String _stepCountValues = "Unknown";
  StreamSubscription<int> _subscription;
  double _cntSteps; //step count
  double _cntKM; // km count
  double _convert;
  int _heartRate;

  // Batimento Cardiaco
  void HeartRate() async{
    Stream<PulseEvent> stream = await Pulse.subscribe();
    stream.listen((PulseEvent event) {
      _heartRate = event.value;
      print("Your current heart rate is: ${event.value}");
    });
  }

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
      setState(() {
        _stepCountValues = "$stepCount";
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

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;
    getDistanceRun(_cntSteps);

    setState(() {
      _convert = long4;
    });
  }

  // Distância em Km
  void getDistanceRun(double _cntSteps){
    var distance = ((_cntSteps * 78)/100000);
    distance = num.parse(distance.toStringAsFixed(2));
    var distancekm = distance * 34;
    distancekm = num.parse(distancekm.toStringAsFixed(2));
    setState(() {
      _km = "$distance";

    });
    setState(() {
      _cntKM = num.parse(distancekm.toStringAsFixed(2));
    });
  }

  // Calorias gastas
  void getCalories(){
    setState(() {
      var calories = _cntKM;
      _calories = "$calories";

    });
  }

  @override
  Widget build(BuildContext context) {
    HeartRate();
    getCalories();
    return Container(
      color: Colors.white24,
      child: ListView(
        padding: EdgeInsets.only(top: 40.0, left: 5.0, right: 5.0,),
        children: <Widget>[
          Container(

            width: 200,
            height: 230,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(27.0),
                bottomRight: Radius.circular(27.0),
                topLeft: Radius.circular(27.0),
                topRight: Radius.circular(27.0),
              )
            ),
            child: CircularPercentIndicator(
                radius: 200.0,
                lineWidth: 13.0,
                animation: true,
                backgroundColor: Colors.grey,
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

          Container(
            padding: EdgeInsets.only(left: 5.0,  bottom: 0.0),
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                Container(
                  child:  Column(
                    children: <Widget>[
                      Card(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),

                            image: DecorationImage(
                              image: AssetImage("assets/distance.png"),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),

                        ),
                      ),
                      Container(

                          width: 150,
                          height: 30,
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 50.0),

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


                    ],
                  )
                ),


              ],
            ),
          ),

                Container(
                  padding: EdgeInsets.only(left: 35.0,  bottom: 0.0),
                  child:  Column(
                    children: <Widget>[
                      Card(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),

                            image: DecorationImage(
                              image: AssetImage("assets/calories.png"),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),

                        ),
                      ),
                      Container(

                          width: 150,
                          height: 30,
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 45.0),

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
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 25.0, top: 5.0),
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 70.0, bottom: 0.0),
                  child:  Column(
                    children: <Widget>[
                      Card(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),

                            image: DecorationImage(
                              image: AssetImage("assets/heart.png"),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),

                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 15.0),
                          width: 150,
                          height: 30,
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 40.0),

                                  child: Container(
                                    child: _heartRate == null?Text(
                                      "Soon",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),

                                  ):
                                    Text(
                                        "$_heartRate bpm",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),

                                    ),
                                ),

                              ),
                            ],
                          )
                      ),


                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


