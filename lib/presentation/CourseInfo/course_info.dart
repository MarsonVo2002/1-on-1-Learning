import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/model/course/course.dart';
import 'package:lettutor/presentation/Course/lesson.dart';
import 'package:lettutor/presentation/CourseInfo/OverviewSection/overview_section.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class CourseInfo extends StatelessWidget {
  final Course course;
  const CourseInfo({super.key, required this.course});
  
  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = context.watch<LanguageProvider>();
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                course.name!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
           Image.network(
            course.imageUrl!,
            errorBuilder: (context, error, stackTrace) 
            {
              return Container();
            },
            width: 300,
            height: 200,
          ),
          OverviewSection(course: course,),
          Text(
           languageProvider.language.level,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
           Padding(padding: EdgeInsets.all(10), child: Text('${levels[course.level!]}')),
          Text(
            languageProvider.language.length,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(padding: EdgeInsets.all(10), child: Text('${course.topics!.length} topic(s)')),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Lesson(topics: course.topics??[],)));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child:  Text(
                  languageProvider.language.discover,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ))
        ]),
      ),
    );
  }
}
