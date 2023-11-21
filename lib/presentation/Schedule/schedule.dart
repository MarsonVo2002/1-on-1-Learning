import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/presentation/Schedule/ScheduleItem/schedule_item.dart';
import 'package:lettutor/presentation/Schedule/TitleSection/title_section.dart';
import 'package:provider/provider.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    provider.account.lesson_list.sort(((a, b) => a.selectedDay.compareTo(b.selectedDay)));
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          const TitleSection(),
          Container(
            height: 400,
            child: ListView.builder(
              itemCount: provider.account.lesson_list.length,
              itemBuilder: (context ,index)
              {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: ScheduleItem(info: provider.account.lesson_list[index]),
                );
              }
            ),
          )
      ],)
    );
  }
}
