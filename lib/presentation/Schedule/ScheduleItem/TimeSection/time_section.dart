import 'package:flutter/material.dart';

class TimeSection extends StatelessWidget {
  final DateTime time;
  const TimeSection({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DateTime endTime = time.add(Duration(minutes: 25));
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().
                    padLeft(2, '0')} - ${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString()
                    .padLeft(2, '0')}'),
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
