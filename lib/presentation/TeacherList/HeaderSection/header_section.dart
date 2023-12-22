import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HeaderSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HeaderSection();
}

class _HeaderSection extends State<HeaderSection> {
  String date = '';
  DateTime upcoming = DateTime.now();
  int index = 0;
  List <BookingInfo> upcoming_classes =[];
  @override
  Widget build(BuildContext context) {
 
    HistoryProvider historyprovider = context.watch<HistoryProvider>();
    ClassInfoProvider classinfoprovider = context.watch<ClassInfoProvider>();
    AccountSessionProvider session = context.watch<AccountSessionProvider>();
    var now = DateTime.now().millisecondsSinceEpoch;
    upcoming_classes = session.booked_class.where(
        (element) => element.scheduleDetailInfo!.startPeriodTimestamp! >= now).toList();
    if (upcoming_classes.isEmpty || index == upcoming_classes.length - 1) {
      return Container(
        alignment: Alignment.center,
        color: Colors.blue,
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: const Text(
          'No Upcoming Lesson',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    } else {
      upcoming = DateTime.fromMillisecondsSinceEpoch(upcoming_classes[index].scheduleDetailInfo!.startPeriodTimestamp ??
          0);
      date = DateFormat('yyyy-MM-dd – H:mm').format(upcoming);
      return Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Upcoming Lesson',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              date,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  setState(() {
                    index++;
                    upcoming = DateTime.fromMillisecondsSinceEpoch(upcoming_classes[index]
                            .scheduleDetailInfo!
                            .startPeriodTimestamp ??
                        0);
                    date =
                        DateFormat('yyyy-MM-dd – H:mm').format(upcoming);
                  });
                  // session.addHistory(session.account.lesson_list[0]);
                  // session.removeLesson(session.account.lesson_list[0]);
                  // historyprovider.add(classinfoprovider.list[0]);
                  // classinfoprovider.remove(classinfoprovider.list[0]);
                },
                child: const Text(
                  'Enter lesson',
                  style: TextStyle(color: Colors.blue),
                )),
            Text(
              'Total lesson time ${session.account.totalLessonTime} minutes',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      );
    }
    // TODO: implement build
  }
}
