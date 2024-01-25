import 'package:flutter/material.dart';
import 'package:lettutor/model/class-info.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/presentation/Schedule/ScheduleItem/DateSection/date_section.dart';
import 'package:lettutor/presentation/Schedule/ScheduleItem/TeacherSection/teacher_section.dart';
import 'package:lettutor/presentation/Schedule/ScheduleItem/TimeSection/time_section.dart';

class ScheduleItem extends StatelessWidget {
  final BookingInfo info;
  const ScheduleItem({super.key, required this.info});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
           
            border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateSection(date:DateTime.fromMillisecondsSinceEpoch(info.scheduleDetailInfo!.startPeriodTimestamp??0)),
            SizedBox(
              height: 10,
            ),
            TeacherSection(
              info: info.scheduleDetailInfo!.scheduleInfo!.tutorInfo!
            ),
            TimeSection(info:info),
          ],
        ));
  }
}
