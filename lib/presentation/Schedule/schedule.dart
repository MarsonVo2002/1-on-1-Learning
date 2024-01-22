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
  int itemsPerPage = 3;
  int currentPage = 0;
  void nextPage() {
    final provider =
        Provider.of<AccountSessionProvider>(context, listen: false);
    if (currentPage <
        (provider.upcoming_classes.length / itemsPerPage).ceil() - 1) {
      setState(() {
        currentPage++;
      });
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    final startIndex = currentPage * itemsPerPage;
    final endIndex = (currentPage + 1) * itemsPerPage;
    return Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const TitleSection(),
            Container(
              height: 400,
              child: provider.upcoming_classes.isNotEmpty
                  ? ListView.builder(
                      itemCount: provider.upcoming_classes
                          .sublist(
                              startIndex,
                              endIndex.clamp(
                                  0, provider.upcoming_classes.length))
                          .length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: ScheduleItem(
                              info: provider.upcoming_classes[index + startIndex]),
                        );
                      })
                  : Center(
                      child: Text("You haven't booked any classes yet"),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: previousPage,
                    icon: const Icon(Icons.navigate_before)),
                Text('${currentPage + 1}'),
                IconButton(
                    onPressed: nextPage,
                    icon: const Icon(Icons.navigate_next)),
              ],
            )
          ],
        ));
  }
}
