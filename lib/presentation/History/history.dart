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

    // TODO: implement build
    return Scaffold(
      body: ListView(children: [
        const HistoryTitleSection(),
        const SizedBox(
          height: 20,
        ),
        Container(
            height: 400,
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: session.history.length,
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
                            date: DateTime.fromMillisecondsSinceEpoch(session
                                    .history[index]
                                    .scheduleDetailInfo!
                                    .startPeriodTimestamp ??
                                0)),
                        SizedBox(
                          height: 10,
                        ),
                        TeacherSection(
                            info: session.history[index].scheduleDetailInfo!
                                .scheduleInfo!.tutorInfo!),
                        ReviewSection(
                          date: DateTime.fromMillisecondsSinceEpoch(session
                                  .history[index]
                                  .scheduleDetailInfo!
                                  .endPeriodTimestamp ??
                              0),
                          info: session.history[index],
                        )
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
