import 'package:flutter/material.dart';
import 'package:lettutor/presentation/Schedule/ScheduleItem/schedule_item.dart';
import 'package:lettutor/presentation/Schedule/TitleSection/title_section.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(10),
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
