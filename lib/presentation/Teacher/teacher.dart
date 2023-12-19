import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/calendar-dto.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/schedule/schedule_info.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/presentation/Teacher/Calendar/calendar.dart';
import 'package:lettutor/presentation/Teacher/Chat/chat.dart';
import 'package:lettutor/presentation/Teacher/LanguagesSection/languages_section.dart';
import 'package:lettutor/presentation/Teacher/OtherSection/other_section.dart';
import 'package:lettutor/presentation/Teacher/SpecialtiesSection/specialties_section.dart';
import 'package:lettutor/presentation/Teacher/SuggestedCourseSection/suggested_course_section.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/AvatarSection/avatar_section.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Widget ReviewSection(TeacherDTO teacher) {
  List<Text> list = [];
  for (int i = 0; i < teacher.review.length; i++) {
    list.add(Text(teacher.review[i]));
  }
  return Container(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: list));
}

Widget Time(List<ScheduleInfo> items, BuildContext context, AccountSessionProvider tutor) {
  List<Widget> list = [];
  for (int i = 0; i < items.length; i++) {
    list.add(ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.white70),
        onPressed: () {
           showDialog(
              context: context,
              builder: (context) => AlertDialog(
                scrollable: true,
                title: const Text("Time"),
                content: Text('You are booking class on ${DateTime.fromMillisecondsSinceEpoch(items[i].startTimestamp!)}'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Back"),
                  ),
                  TextButton(
                    onPressed: () async{
                      BookingService.BookClass([items[i].scheduleDetails?.first.id ?? ''], '', accessToken);
                      
                     
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
        },
        child: Text(
          '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(items[i].startTimestamp ?? 0))} - ${
            DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(items[i].endTimestamp ?? 0))}',
          style: const TextStyle(color: Colors.black),
        )));
  }
  return Wrap(
    spacing: 2,
    children: list,
  );
}

Widget Date(
    List<DateTime> item, BuildContext context, List<ScheduleInfo> schedules, AccountSessionProvider tutor) {
  List<Widget> list = [];
  for (int i = 0; i < item.length; i++) {
    list.add(
      ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blue),
          onPressed: () async {
            List<ScheduleInfo> times = schedules.where(
              (element) {
                DateTime e = DateTime.fromMillisecondsSinceEpoch(
                    element.startTimestamp ?? 0);
                if (e.day == item[i].day &&
                    e.month == item[i].month &&
                    e.year == item[i].year) {
                  return true;
                } else {
                  return false;
                }
              },
            ).toList();
            times
                .sort((a, b) => a.startTimestamp!.compareTo(b.startTimestamp!));
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                scrollable: true,
                title: const Text("Time"),
                content: Time(times, context, tutor),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          },
          child: Text(
            '${item[i].day}/${item[i].month}/${item[i].year}',
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
  return Wrap(direction: Axis.horizontal, spacing: 5, children: list);
}

class Teacher extends StatelessWidget {
  final Tutor teacher;
  final TutorInfo info;
  final List<ScheduleInfo> schedules;
  const Teacher(
      {super.key,
      required this.teacher,
      required this.info,
      required this.schedules});

  @override
  Widget build(BuildContext context) {
    AccountSessionProvider tutor = context.watch<AccountSessionProvider>();
    List<DateTime> timetable = schedules
        .map((e) => DateTime.fromMillisecondsSinceEpoch(e.startTimestamp ?? 0))
        .toList();
    timetable = timetable
        .map(
            (dateTime) => DateTime(dateTime.year, dateTime.month, dateTime.day))
        .toSet()
        .toList();
    timetable.sort();
    for (int i = 0; i < timetable.length; i++) {
      print(timetable[i]);
    }
    // TODO: implement build
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              AvatarSection(
                teacher: teacher,
              ),
              Text(info.bio!),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.apps_outage_outlined),
                        color: Colors.blue,
                      ),
                      Text(
                        'Report',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) =>  AlertDialog(
                          //       scrollable: true,
                          //       title: const Text("Review"),
                          //       content:
                          //           ReviewSection(teacher),
                          //       actions: <Widget>[
                          //         TextButton(
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //           child: const Text("OK"),
                          //         ),
                          //       ],
                          //     ),

                          // );
                        },
                        icon: Icon(Icons.star),
                        color: Colors.blue,
                      ),
                      Text(
                        'Review',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Chat(
                          //               teacher: teacher,
                          //             )));
                        },
                        icon: Icon(Icons.chat),
                        color: Colors.blue,
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ],
              ),
              // Image(
              //   image: AssetImage(teacher.video),
              //   width: 200,
              //   height: 102,
              // ),
              LanguagesSection(items: info.languages!.split(',')),
              SpecialtiesSection(items: info.specialties!.split(',')),
              // SuggestedCourseSection(),
              OtherSection(title: 'Interests', content: info.interests!),
              OtherSection(
                  title: 'Teaching experience', content: info.experience!),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Date(timetable, context, schedules, tutor)
                  ],
                ),
              )
            ],
          )),
    );
  }
}
