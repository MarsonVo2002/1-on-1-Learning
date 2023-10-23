import 'package:flutter/material.dart';

import '../Schedule/ScheduleItem/DateSection/date_section.dart';
import '../Schedule/ScheduleItem/TeacherSection/teacher_section.dart';
import 'HistoryTitleSection/history_title_section.dart';
import 'ReviewSection/review_section.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(children: [
        const HistoryTitleSection(),
        const SizedBox(height: 20,),
        Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(20)),
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
                ReviewSection()
              ],
            ))
      ]),
    );
  }
}
