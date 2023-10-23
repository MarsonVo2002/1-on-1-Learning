import 'package:flutter/material.dart';
import 'package:lettutor/presentation/Course/CourseSection/course_section.dart';
import 'package:lettutor/presentation/Course/CourseTitleSection/course_title_section.dart';

class Course extends StatelessWidget {
  const Course({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(children: const [
        CourseTitleSection(),
        SizedBox( height: 20),
        TextField(
            decoration: InputDecoration(
                hintText: 'Search',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue)),
                suffixIcon: Icon(Icons.search))),
        Row(
          children: [
            Text('Level: '),
            Flexible(
              child: TextField(
                  decoration:
                      InputDecoration(suffixIcon: Icon(Icons.arrow_drop_down))),
            )
          ],
        ),
        Row(
          children: [
            Text('Category: '),
            Flexible(
              child: TextField(
                  decoration:
                      InputDecoration(suffixIcon: Icon(Icons.arrow_drop_down))),
            )
          ],
        ),
        SizedBox(height: 30,),
        CourseSection(),
      ]),
    );
  }
}
