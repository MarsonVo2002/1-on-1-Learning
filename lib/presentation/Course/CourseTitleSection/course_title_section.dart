import 'package:flutter/material.dart';

class CourseTitleSection extends StatelessWidget
{
  const CourseTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(10),
        child: const Row(
          children: [
            Icon(
              Icons.book,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Courses',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ));
  }

}