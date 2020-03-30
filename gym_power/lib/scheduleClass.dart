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
                    title: "ABS""\n\n",
                    textStyle: TextStyle(),

                    padding: EdgeInsets.fromLTRB(15, 10, 1, 1),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    onTap: (){},

                    start: TableEventTime(hour: 8, minute: 0),
                    end: TableEventTime(hour: 9, minute: 0),
                  ),

                ]
            ),
            LaneEvents(
                lane: Lane(
                  name: 'Tuesday',

                  width: 60
                ),
                events: [

                ]
            ),
            LaneEvents(
                lane: Lane(
                  name: 'Wednesday',
                  width: 75
                ),
                events: [

                ]
            ),
            LaneEvents(
                lane: Lane(
                    name: 'Thursday',
                    width: 60
                ),
                events: [
                  TableEvent(
                    title: 'An event 1',

                    start: TableEventTime(hour: 10, minute: 0),
                    end: TableEventTime(hour: 11, minute: 20),
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
                    title: 'An event 1',

                    start: TableEventTime(hour: 10, minute: 0),
                    end: TableEventTime(hour: 11, minute: 20),
                  ),
                ]
            ),
          ],
        ),
      )
    );

  }
}
