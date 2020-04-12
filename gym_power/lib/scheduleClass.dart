import 'package:flutter/material.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_power/classDetails.dart';
import 'package:gym_power/sidebar.dart';

class ScheduleClasses extends StatefulWidget {
  final String nome;
  final String img;
  final int numSocio;

  const ScheduleClasses({Key key, this.nome, this.img, this.numSocio}) : super(key: key);

  @override
  _ScheduleClassesState createState() => _ScheduleClassesState();
}

class _ScheduleClassesState extends State<ScheduleClasses> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children: <Widget>[
            Container(
              child: TimetableView(
                timetableStyle: TimetableStyle(
                  startHour: 8,
                  endHour: 20,
                  timeItemWidth: 35,
                  //timeItemHeight: 45,
                  cornerColor: Colors.black,
                  laneWidth: 65,

                ),
                laneEventsList: [
                  LaneEvents(
                      lane: Lane(
                          name: 'Monday',
                          width: 60
                      ),
                      events: [
                        TableEvent(
                          title: "Z",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "mKEvfdipyno1dYitMvEP",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 7, minute: 20),
                          end: TableEventTime(hour: 7, minute: 50),
                        ),
                        TableEvent(
                          title: "Z",
                          textStyle: TextStyle(),
                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "mKEvfdipyno1dYitMvEP",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 8, minute: 00),
                          end: TableEventTime(hour: 8, minute: 45),
                        ),
                        TableEvent(
                          title: "Z",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "mKEvfdipyno1dYitMvEP",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 18, minute: 30),
                          end: TableEventTime(hour: 19, minute: 15),
                        ),
                        TableEvent(
                          title: "BB",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "hbTMC2vuVwgoGtH9oW9c",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 12, minute: 45),
                          end: TableEventTime(hour: 13, minute: 35),
                        ),
                        TableEvent(
                          title: "ABS",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.brown,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "pi7QTxuiPu1BrTeRatoO",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 18, minute: 00),
                          end: TableEventTime(hour: 18, minute: 45),
                        ),
                        TableEvent(
                          title: "ABS",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.brown,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "pi7QTxuiPu1BrTeRatoO",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 10, minute: 00),
                          end: TableEventTime(hour: 10, minute: 45),
                        ),
                        TableEvent(
                          title: "B",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "yY8J7eR0w8UhGUayvfzg",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 9, minute: 00),
                          end: TableEventTime(hour: 9, minute: 45),
                        ),
                      ]
                  ),
                  LaneEvents(
                      lane: Lane(
                          name: 'Tuesday',

                          width: 60
                      ),
                      events: [
                        TableEvent(
                          title: "Cy",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "JnRSN3bWszNv0tz3RV8G",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);

                          },

                          start: TableEventTime(hour: 8, minute: 45),
                          end: TableEventTime(hour: 9, minute: 30),
                        ),
                        TableEvent(
                          title: "PI",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "OKLT7MznqGebYdlJLONU",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 18, minute: 00),
                          end: TableEventTime(hour: 18, minute: 30),
                        ),
                        TableEvent(
                          title: "PI",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "OKLT7MznqGebYdlJLONU",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 12, minute: 30),
                          end: TableEventTime(hour: 13, minute: 15),
                        ),
                        TableEvent(
                          title: "ST",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "Qgy2wJD3CwDkosCKZG4j",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 15, minute: 15),
                          end: TableEventTime(hour: 16, minute: 00),
                        ),
                        TableEvent(
                          title: "KB",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "f5FwfM8r2EqzoCqmA2Rj",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 9, minute: 00),
                          end: TableEventTime(hour: 9, minute: 45),
                        ),
                        TableEvent(
                          title: "ABS",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.brown,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "pi7QTxuiPu1BrTeRatoO",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 10, minute: 00),
                          end: TableEventTime(hour: 10, minute: 30),
                        ),
                        TableEvent(
                          title: "B",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "yY8J7eR0w8UhGUayvfzg",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 18, minute: 00),
                          end: TableEventTime(hour: 18, minute: 30),
                        ),
                      ]
                  ),
                  LaneEvents(
                      lane: Lane(
                          name: 'Wednesday',
                          width: 75
                      ),
                      events: [
                        TableEvent(
                          title: "Cy",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "JnRSN3bWszNv0tz3RV8G",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 15, minute: 00),
                          end: TableEventTime(hour: 15, minute: 40),
                        ),
                        TableEvent(
                          title: "PI",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "OKLT7MznqGebYdlJLONU",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 11, minute: 00),
                          end: TableEventTime(hour: 11, minute: 30),
                        ),
                        TableEvent(
                          title: "KB",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "f5FwfM8r2EqzoCqmA2Rj",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 17, minute: 00),
                          end: TableEventTime(hour: 17, minute: 40),
                        ),
                        TableEvent(
                          title: "KB",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "f5FwfM8r2EqzoCqmA2Rj",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 16, minute: 00),
                          end: TableEventTime(hour: 16, minute: 15),
                        ),
                        TableEvent(
                          title: "BB",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "hbTMC2vuVwgoGtH9oW9c",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 15, minute: 15),
                          end: TableEventTime(hour: 15, minute: 45),
                        ),
                        TableEvent(
                          title: "ABS",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.brown,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "pi7QTxuiPu1BrTeRatoO",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 9, minute: 00),
                          end: TableEventTime(hour: 9, minute: 45),
                        ),

                      ]
                  ),
                  LaneEvents(
                      lane: Lane(
                          name: 'Thursday',
                          width: 60
                      ),
                      events: [
                        TableEvent(
                          title: "Cy",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "JnRSN3bWszNv0tz3RV8G",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 16, minute: 15),
                          end: TableEventTime(hour: 16, minute: 40),
                        ),
                        TableEvent(
                          title: "ST",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "Qgy2wJD3CwDkosCKZG4j",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 15, minute: 15),
                          end: TableEventTime(hour: 16, minute: 00),
                        ),
                        TableEvent(
                          title: "Z",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "mKEvfdipyno1dYitMvEP",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 10, minute: 40),
                          end: TableEventTime(hour: 11, minute: 15),
                        ),
                        TableEvent(
                          title: "Z",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "mKEvfdipyno1dYitMvEP",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 14, minute: 00),
                          end: TableEventTime(hour: 14, minute: 30),
                        ),
                        TableEvent(
                          title: "ABS",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.brown,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "pi7QTxuiPu1BrTeRatoO",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 10, minute: 00),
                          end: TableEventTime(hour: 10, minute: 45),
                        ),
                      ]
                  ),
                  LaneEvents(
                      lane: Lane(
                          name: 'Friday',
                          width: 60
                      ),
                      events: [
                        TableEvent(
                          title: "Cy",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "JnRSN3bWszNv0tz3RV8G",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 8, minute: 45),
                          end: TableEventTime(hour: 9, minute: 30),
                        ),
                        TableEvent(
                          title: "PI",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "OKLT7MznqGebYdlJLONU",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 18, minute: 20),
                          end: TableEventTime(hour: 18, minute: 50),
                        ),
                        TableEvent(
                          title: "KB",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "f5FwfM8r2EqzoCqmA2Rj",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 9, minute: 00),
                          end: TableEventTime(hour: 9, minute: 30),
                        ),
                        TableEvent(
                          title: "KB",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "f5FwfM8r2EqzoCqmA2Rj",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 10, minute: 15),
                          end: TableEventTime(hour: 10, minute: 45),
                        ),
                        TableEvent(
                          title: "Z",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "mKEvfdipyno1dYitMvEP",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 16, minute: 20),
                          end: TableEventTime(hour: 16, minute: 40),
                        ),
                        TableEvent(
                          title: "B",
                          textStyle: TextStyle(),

                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "yY8J7eR0w8UhGUayvfzg",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 14, minute: 45),
                          end: TableEventTime(hour: 15, minute: 20),
                        ),
                        TableEvent(
                          title: "B",
                          textStyle: TextStyle(),
                          padding: EdgeInsets.fromLTRB(15, 50, 1, 1),
                          decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                          ),
                          onTap: (){
                            var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: "yY8J7eR0w8UhGUayvfzg",  nome: widget.nome, img: widget.img, numSocio: widget.numSocio, ));
                            Navigator.of(context).push(route);
                          },

                          start: TableEventTime(hour: 18, minute: 20),
                          end: TableEventTime(hour: 18, minute: 50),
                        ),
                      ]
                  ),
                ],
              ),
            ),
            Container(
              //padding: EdgeInsets.fromLTRB(0, 10, 60, 1000),

              height: 50,
              width: 40,
              //padding: EdgeInsets.fromLTRB(0, 10, 100, 0),
              margin: EdgeInsets.fromLTRB(0, 10, 100, 0),
              alignment: Alignment.topLeft,
              child: IconButton(

                  padding: EdgeInsets.fromLTRB(2.5, 10, 300, 250),
                  icon: Icon(Icons.info_outline, size: 30,),
                  splashColor: Colors.grey,
                  hoverColor: Colors.grey,
                  onPressed: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        elevation: 10.0,
                        contentPadding: EdgeInsets.all(10),
                        title: Text("Colors Info"),
                        content:  Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.solidCircle, color: Colors.greenAccent,),
                                SizedBox(width: 10,),
                                Text("Zumba"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.solidCircle, color: Colors.deepOrangeAccent,),
                                SizedBox(width: 10,),
                                Text("Bumfit"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.solidCircle, color: Colors.blueAccent,),
                                SizedBox(width: 10,),
                                Text("Body Balance"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.solidCircle, color: Colors.grey,),
                                SizedBox(width: 10,),
                                Text("Pilates"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.solidCircle, color: Colors.redAccent,),
                                SizedBox(width: 10,),
                                Text("Cycling"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.solidCircle, color: Colors.pinkAccent,),
                                SizedBox(width: 10,),
                                Text("Step"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.solidCircle, color: Colors.deepPurpleAccent,),
                                SizedBox(width: 10,),
                                Text("KickBoxing"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.solidCircle, color: Colors.brown,),
                                SizedBox(width: 10,),
                                Text("Core(ABS)"),
                              ],
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      );
                    });
                  }
              )
            ),
          ],
        )
    );

  }
}