// class BookingScreen extends StatefulWidget {
//   @override
//   _BookingScreenState createState() => _BookingScreenState();
// }

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/class-info.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Appointment> _getAppointment(
    List<int> schedule, List<String> time, List<bool> isBook) {
  List<Appointment> appointments = [];
  DateTime today = DateTime.now();
  for (int i = 0; i < schedule.length; i++) {
    while (today.weekday != schedule[i]) {
      today = today.add(Duration(days: 1));
    }
    DateTime lesson = DateTime(today.year, today.month, today.day,
        int.parse(time[i].split(':')[0]), int.parse(time[i].split(':')[1]));
    if (isBook[i] == true) {
      appointments.add(Appointment(
          startTime: lesson,
          endTime: lesson.add(Duration(minutes: 30)),
          subject: 'Booked',
          color: Colors.red));
    } else {
      appointments.add(Appointment(
          startTime: lesson,
          endTime: lesson.add(Duration(minutes: 30)),
          subject: 'Book',
          color: Colors.blue));
    }
  }

  return appointments;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class Calendar extends StatelessWidget {
  TeacherDTO teacher;

  Appointment _selectedAppointment = Appointment(
      startTime: DateTime.now(), endTime: DateTime.now(), subject: 'null');

  Calendar({required this.teacher});
  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Appointment appointment = calendarTapDetails.appointments![0];
      _selectedAppointment = appointment;
      if (_selectedAppointment.subject == 'Book') {
        _selectedAppointment.subject = 'Booked';
        _selectedAppointment.color = Colors.red;
        print(_selectedAppointment.subject);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MeetingDataSource source = MeetingDataSource(
        _getAppointment(teacher.schedule, teacher.time, teacher.isBook));
    
    ClassInfoProvider classinfoprovider = context.watch<ClassInfoProvider>();
    AccountSessionProvider session = context.watch<AccountSessionProvider>();
    // TODO: implement build
    return Container(
      height: 400,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                print(_selectedAppointment.startTime);
                if (_selectedAppointment.subject != 'null') {
                  int index =
                      source.appointments!.indexOf(_selectedAppointment);
                  source.appointments!.removeAt(index);
                  source.notifyListeners(CalendarDataSourceAction.remove,
                      <Appointment>[]..add(_selectedAppointment));
                  source.appointments!.add(_selectedAppointment);
                  source.notifyListeners(CalendarDataSourceAction.add,
                      <Appointment>[]..add(_selectedAppointment));
                  teacher.isBook[index] = true;
                  if (!session.account.lesson_list.contains(_selectedAppointment.startTime)) {
                
                    session.addLesson(ClassInfo(
                        selectedDay: _selectedAppointment.startTime,
                        teacher: teacher));
                  }
                }
              },
              child: Text('Book')),
          SfCalendar(
            view: CalendarView.week,
            dataSource: source,
            timeSlotViewSettings: TimeSlotViewSettings(
              timeInterval: Duration(minutes: 25),
              timeIntervalWidth: 200,
              startHour: 15,
              endHour: 23,
              timeFormat: 'H:mm',
              dateFormat: 'd',
              dayFormat: 'EEE',
            ),
            onTap: calendarTapped,
          ),
        ],
      ),
    );
  }
}
