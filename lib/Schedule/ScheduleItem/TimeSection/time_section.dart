import 'package:flutter/material.dart';

class TimeSection extends StatelessWidget {
  const TimeSection({super.key});

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
                const Text('18:30 - 18:55'),
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
                Text('Edit Request', style: TextStyle(color: Colors.blue),),
            ],)
          ],
        ));
  }
}
