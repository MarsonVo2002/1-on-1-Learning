import 'package:flutter/material.dart';
import 'package:lettutor/Schedule/ScheduleItem/DateSection/date_section.dart';
import 'package:lettutor/Schedule/ScheduleItem/TeacherSection/teacher_section.dart';
import 'package:lettutor/Schedule/ScheduleItem/TimeSection/time_section.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(), borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateSection(),
            SizedBox(
              height: 10,
            ),
            TeacherSection(
                name: 'Keeran',
                avatarpath: 'asset/images/avatar.png',
                nationality: 'France',
                flagpath: 'asset/images/france.png'),
            TimeSection()
          ],
        ));
  }
}
