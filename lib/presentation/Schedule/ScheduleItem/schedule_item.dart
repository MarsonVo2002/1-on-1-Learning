import 'package:flutter/material.dart';
import 'package:lettutor/model/class-info.dart';
import 'package:lettutor/presentation/Schedule/ScheduleItem/DateSection/date_section.dart';
import 'package:lettutor/presentation/Schedule/ScheduleItem/TeacherSection/teacher_section.dart';
import 'package:lettutor/presentation/Schedule/ScheduleItem/TimeSection/time_section.dart';

class ScheduleItem extends StatelessWidget {
  final ClassInfo info;
  const ScheduleItem({super.key, required this.info});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(), borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateSection(date:info.selectedDay),
            SizedBox(
              height: 10,
            ),
            TeacherSection(
                name: info.teacher.name,
                avatarpath: info.teacher.avatarpath,
                nationality: info.teacher.nationality,
                flagpath: info.teacher.flaticon),
            TimeSection(time: info.selectedDay),
          ],
        ));
  }
}
