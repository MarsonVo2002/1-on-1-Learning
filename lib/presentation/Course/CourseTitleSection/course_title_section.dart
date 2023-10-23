import 'package:flutter/material.dart';

class CourseTitleSection extends StatelessWidget
{
  const CourseTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(10),
        color: Colors.blue,
        child: const Row(
          children: [
            Icon(
              Icons.book,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Courses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ));
  }

}