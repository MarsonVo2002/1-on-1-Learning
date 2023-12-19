import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/model/schedule/booking_info.dart';

class TimeSection extends StatelessWidget {
  final BookingInfo info;
  const TimeSection({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${DateFormat.Hm().format
                    (DateTime.fromMillisecondsSinceEpoch
                    (info.scheduleDetailInfo!.startPeriodTimestamp ?? 0))} - ${DateFormat.Hm().
                    format(DateTime.fromMillisecondsSinceEpoch(
                    info.scheduleDetailInfo!.endPeriodTimestamp ?? 0))}'),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {},
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Request for lesson'),
                Text(
                  'Edit Request',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            )
          ],
        ));
  }
}
