import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:provider/provider.dart';

class TimeSection extends StatelessWidget {
  final BookingInfo info;
  const TimeSection({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    LanguageProvider languageProvider = context.watch<LanguageProvider>();
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(info.scheduleDetailInfo!.startPeriodTimestamp ?? 0))} - ${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(info.scheduleDetailInfo!.endPeriodTimestamp ?? 0))}',
                 
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      DateTime time = DateTime.fromMillisecondsSinceEpoch(
                              info.scheduleDetailInfo!.startPeriodTimestamp ??
                                  0)
                          .subtract(const Duration(hours: 2));
                      //Test
                      // DateTime test = DateTime(2024, 1, 22, 21);
                      (DateTime.now().isBefore(time) ||
                              time.isAtSameMomentAs(DateTime.now()))
                          ? showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Cancel class'),
                                content: const Text(
                                    'Are you sure to cancel this class?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('NO'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await BookingService.cancelBookedClass(
                                        [info.id ?? ''],
                                        accessToken,
                                      );
                                      print(info.id);
                                      List<BookingInfo> upcoming =
                                          await BookingService
                                              .GetAllUpcomingClasses(
                                                  accessToken);
                              
                                      provider.setUpcomingClasses(upcoming);
                                      provider.sortUpcomingClasses();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('YES'),
                                  ),
                                ],
                              ),
                            )
                          : showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: const Text('Cancel class'),
                                      content: const Text(
                                          'You can only cancel the meeting before 2 hours!'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Back'),
                                        ),
                                      ]));
                    },
                    child: Text(
                      languageProvider.language.Cancel,
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Requests For Lesson'),
                          content: TextField(
                            minLines: 2,
                            maxLines: 4,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    languageProvider.language.Request,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
