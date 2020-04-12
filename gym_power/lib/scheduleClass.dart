import 'package:flutter/material.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';

class ScheduleClasses extends StatefulWidget {
  @override
  _ScheduleClassesState createState() => _ScheduleClassesState();
}

class _ScheduleClassesState extends State<ScheduleClasses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 10, 50),
          child: TimetableView(
            timetableStyle: TimetableStyle(
              startHour: 8,
              endHour: 20,
              timeItemWidth: 35,
              timeItemHeight: 45,
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
                      title: "BB",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 12, minute: 45),
                      end: TableEventTime(hour: 13, minute: 35),
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

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 8, minute: 45),
                      end: TableEventTime(hour: 9, minute: 30),
                    ),
                    TableEvent(
                      title: "PI",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 18, minute: 00),
                      end: TableEventTime(hour: 18, minute: 30),
                    ),
                    TableEvent(
                      title: "PI",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 12, minute: 30),
                      end: TableEventTime(hour: 13, minute: 15),
                    ),
                    TableEvent(
                      title: "ST",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 15, minute: 15),
                      end: TableEventTime(hour: 16, minute: 00),
                    ),
                    TableEvent(
                      title: "KB",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 9, minute: 00),
                      end: TableEventTime(hour: 9, minute: 45),
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

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 15, minute: 00),
                      end: TableEventTime(hour: 15, minute: 40),
                    ),
                    TableEvent(
                      title: "PI",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 11, minute: 00),
                      end: TableEventTime(hour: 11, minute: 30),
                    ),
                    TableEvent(
                      title: "KB",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 17, minute: 00),
                      end: TableEventTime(hour: 17, minute: 40),
                    ),
                    TableEvent(
                      title: "KB",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 16, minute: 00),
                      end: TableEventTime(hour: 16, minute: 15),
                    ),
                    TableEvent(
                      title: "BB",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 15, minute: 15),
                      end: TableEventTime(hour: 15, minute: 45),
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

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 16, minute: 15),
                      end: TableEventTime(hour: 16, minute: 40),
                    ),
                    TableEvent(
                      title: "ST",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 15, minute: 15),
                      end: TableEventTime(hour: 16, minute: 00),
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

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 8, minute: 45),
                      end: TableEventTime(hour: 9, minute: 30),
                    ),
                    TableEvent(
                      title: "PI",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 18, minute: 20),
                      end: TableEventTime(hour: 18, minute: 50),
                    ),
                    TableEvent(
                      title: "KB",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 9, minute: 00),
                      end: TableEventTime(hour: 9, minute: 30),
                    ),
                    TableEvent(
                      title: "KB",
                      textStyle: TextStyle(),

                      padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                      ),
                      onTap: (){},

                      start: TableEventTime(hour: 10, minute: 15),
                      end: TableEventTime(hour: 10, minute: 45),
                    ),
                  ]
              ),
            ],
          ),
        )
    );

  }
}