import 'package:flutter/material.dart';
import 'package:lettutor/presentation/Course/CourseSection/course_section.dart';
import 'package:lettutor/presentation/Course/CourseTitleSection/course_title_section.dart';
import 'package:lettutor/presentation/CourseInfo/course_info.dart';

class Course extends StatelessWidget {
  const Course({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.bookmark), text: 'Course',),
                Tab(icon: Icon(Icons.info,), text: 'Course info'),
              ],
            ),
          ),
          body:  const TabBarView(
            children: [
              CourseSection(),
              CourseInfo()
            ],
          ),
        ),
      );
    
   
  }
}
