import 'package:flutter/material.dart';
import 'package:lettutor/Schedule/ScheduleItem/schedule_item.dart';
import 'package:lettutor/Schedule/TitleSection/title_section.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: const Color.fromARGB(255, 195, 193, 193),
      child: ListView(
        children: const [
          TitleSection(),
          Padding(
            padding: EdgeInsets.all(20),
            child: ScheduleItem(),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: ScheduleItem(),
          ),
        ],
      ),
    );
  }
}
