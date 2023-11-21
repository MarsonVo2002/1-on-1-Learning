import 'package:flutter/material.dart';
import 'package:lettutor/model/course-dto.dart';

class OverviewSection extends StatelessWidget {
  final CourseInformation course;
  const OverviewSection({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Why take this course',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding:  EdgeInsets.all(10),
          child: Text(course.why)
        ),
        const Text(
          'What will you be able to do',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding:  EdgeInsets.all(10),
          child: Text(course.what)
        )

      ],
    );
  }
}
