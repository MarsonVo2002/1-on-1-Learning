import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:provider/provider.dart';

class TimeSection extends StatelessWidget {
  final BookingInfo info;
  const TimeSection({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(info.scheduleDetailInfo!.startPeriodTimestamp ?? 0))} - ${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(info.scheduleDetailInfo!.endPeriodTimestamp ?? 0))}'),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cancel class'),
                          content:
                              const Text('Are you sure to cancel this class?'),
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
                                List<BookingInfo> update =
                                    await BookingService.GetBookedClass(
                                        accessToken);
                                provider.setBookedClass(update);
                                provider.sortBookedClasses();
                                Navigator.pop(context);
                              },
                              child: const Text('YES'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Request for lesson'),
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
                  child: const Text(
                    'Edit Request',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
