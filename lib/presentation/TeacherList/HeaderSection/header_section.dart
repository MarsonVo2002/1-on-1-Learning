import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
  
    HistoryProvider historyprovider = context.watch<HistoryProvider>();
    ClassInfoProvider classinfoprovider = context.watch<ClassInfoProvider>();
    AccountSessionProvider session = context.watch<AccountSessionProvider>();
    
    session.account.lesson_list
        .sort(((a, b) => a.selectedDay.compareTo(b.selectedDay)));
    if ( session.account.lesson_list.isEmpty) {
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
      String date = DateFormat('yyyy-MM-dd – H:mm')
          .format(session.account.lesson_list[0].selectedDay);
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
                  session.addHistory(session.account.lesson_list[0]);
                  session.removeLesson(session.account.lesson_list[0]);
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
