import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(10),
        child: const Row(
          children: [
            Icon(
              Icons.calendar_month,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Schedule',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ));
  }
}
