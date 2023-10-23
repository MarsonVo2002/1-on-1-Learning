import 'package:flutter/material.dart';

class HistoryTitleSection extends StatelessWidget {
  const HistoryTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(10),
        child: const Row(
          children: [
            Icon(
              Icons.history,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ));
  }
}
