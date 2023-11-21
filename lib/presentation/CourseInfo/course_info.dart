import 'package:flutter/material.dart';
import 'package:lettutor/model/course-dto.dart';
import 'package:lettutor/presentation/CourseInfo/OverviewSection/overview_section.dart';

class CourseInfo extends StatelessWidget {
  final CourseInformation course;
  const CourseInfo({super.key, required this.course});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                course.topic,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
           Image(
            image: AssetImage(course.image),
            width: 300,
            height: 200,
          ),
          OverviewSection(course: course,),
          Text(
            course.level,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Padding(padding: EdgeInsets.all(10), child: Text('Beginner')),
          const Text(
            'Course length',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(padding: EdgeInsets.all(10), child: Text('${course.length} topic(s)')),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: const Text(
                  'Discover',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ))
        ]),
      ),
    );
  }
}
