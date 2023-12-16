import 'package:flutter/material.dart';
import 'package:lettutor/presentation/Course/CourseSection/course_section.dart';
import 'package:lettutor/presentation/Course/CourseTitleSection/course_title_section.dart';
import 'package:lettutor/presentation/CourseInfo/course_info.dart';

class Course_UI extends StatelessWidget {
  const Course_UI({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CourseSection(),
    );
  }
}
