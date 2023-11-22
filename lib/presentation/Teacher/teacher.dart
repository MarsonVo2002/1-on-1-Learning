import 'package:flutter/material.dart';
import 'package:lettutor/model/calendar-dto.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/presentation/Teacher/Calendar/calendar.dart';
import 'package:lettutor/presentation/Teacher/Chat/chat.dart';
import 'package:lettutor/presentation/Teacher/LanguagesSection/languages_section.dart';
import 'package:lettutor/presentation/Teacher/OtherSection/other_section.dart';
import 'package:lettutor/presentation/Teacher/SpecialtiesSection/specialties_section.dart';
import 'package:lettutor/presentation/Teacher/SuggestedCourseSection/suggested_course_section.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/AvatarSection/avatar_section.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
Widget ReviewSection(TeacherDTO teacher) {
  List<Text> list=[];
  for(int i = 0; i < teacher.review.length; i++)
  {
    list.add(Text(teacher.review[i]));
  }
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list));
}

class Teacher extends StatelessWidget {
  final TeacherDTO teacher;

  const Teacher({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              AvatarSection(
                teacher: teacher,
              ),
              Text(teacher.detail.description),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.apps_outage_outlined),
                        color: Colors.blue,
                      ),
                      Text(
                        'Report',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) =>  AlertDialog(
                                scrollable: true,
                                title: const Text("Review"),
                                content:
                                    ReviewSection(teacher),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            
                          );
                        },
                        icon: Icon(Icons.star),
                        color: Colors.blue,
                      ),
                      Text(
                        'Review',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chat(
                                        teacher: teacher,
                                      )));
                        },
                        icon: Icon(Icons.chat),
                        color: Colors.blue,
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ],
              ),
              Image(
                image: AssetImage(teacher.video),
                width: 200,
                height: 102,
              ),
              LanguagesSection(items: teacher.languages),
              SpecialtiesSection(items:teacher.detail.specialities),
              SuggestedCourseSection(),
              OtherSection(
                  title: 'Interests',
                  content:
                      teacher.interests),
              OtherSection(
                  title: 'Teaching experience',
                  content:
                      teacher.experience),
              Calendar(teacher: teacher)
            ],
          )),
    );
  }
}
