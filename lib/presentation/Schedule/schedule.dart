import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/presentation/Schedule/ScheduleItem/schedule_item.dart';
import 'package:lettutor/presentation/Schedule/TitleSection/title_section.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:provider/provider.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    return Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const TitleSection(),
            Container(
              height: 400,
              child: ListView.builder(
                  itemCount: provider.booked_class.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: ScheduleItem(info: provider.booked_class[index]),
                    );
                  }),
            )
          ],
        ));
  }
}
