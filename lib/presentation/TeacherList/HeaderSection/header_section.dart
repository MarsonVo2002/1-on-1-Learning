import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    DateTimeProvider datetimeprovider = context.watch<DateTimeProvider>();
    datetimeprovider.list.sort();
    if (datetimeprovider.list.isEmpty) {
      return Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: const Text(
          'No Upcoming Lesson',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    } else {
       String date = DateFormat('yyyy-MM-dd – H:mm').format(datetimeprovider.list[0]);
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
                onPressed: () {},
                child: const Text(
                  'Enter lesson',
                  style: TextStyle(color: Colors.blue),
                )),
             Text(
              'Total lesson time ${datetimeprovider.totalLessonTime} minutes',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      );
    }
    // TODO: implement build
  }
}
