import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:provider/provider.dart';

import '../Schedule/ScheduleItem/DateSection/date_section.dart';
import '../Schedule/ScheduleItem/TeacherSection/teacher_section.dart';
import 'HistoryTitleSection/history_title_section.dart';
import 'ReviewSection/review_section.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    AccountSessionProvider session = context.watch<AccountSessionProvider>();
    HistoryProvider historyProvider = context.watch<HistoryProvider>();
    session.account.history_list
        .sort(((a, b) => a.selectedDay.compareTo(b.selectedDay)));
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(children: [
        const HistoryTitleSection(),
        const SizedBox(
          height: 20,
        ),
        Container(
            height: 400,
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: session.account.history_list.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        DateSection(
                            date: session.account.history_list[index].selectedDay),
                        SizedBox(
                          height: 10,
                        ),
                        // TeacherSection(
                        //     name: session.account.history_list[index].teacher.name,
                        //     avatarpath:
                        //         session.account.history_list[index].teacher.avatarpath,
                        //     nationality:
                        //         session.account.history_list[index].teacher.nationality,
                        //     flagpath:
                        //         session.account.history_list[index].teacher.flaticon),
                        ReviewSection( date: session.account.history_list[index].selectedDay)
                      ],
                    ),
                  ),
                );
              },
            ))
      ]),
    );
  }
}
