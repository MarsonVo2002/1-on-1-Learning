import 'package:flutter/material.dart';

class OtherSection extends StatelessWidget {
  final String title;
  final String content;
  const OtherSection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(content),
            )
          ],
        ));
  }
}
