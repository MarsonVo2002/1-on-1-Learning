import 'package:flutter/material.dart';
import 'package:lettutor/presentation/Teacher/LanguagesSection/languages_section.dart';
import 'package:lettutor/presentation/Teacher/OtherSection/other_section.dart';
import 'package:lettutor/presentation/Teacher/SpecialtiesSection/specialties_section.dart';
import 'package:lettutor/presentation/Teacher/SuggestedCourseSection/suggested_course_section.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/AvatarSection/avatar_section.dart';

class Teacher extends StatelessWidget {
  const Teacher({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: const [
              AvatarSection(
                  name: 'Keeran',
                  avatarpath: 'asset/images/avatar.png',
                  nationality: 'France',
                  flagpath: 'asset/images/france.png'),
              Text(
                  'I am passionate about running and fitness, I often compete in trail/mountain running '
                  'events and I love pushing myself. I am training to one day take part in ultra-en...'),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.apps_outage_outlined,
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
                      Icon(
                        Icons.star,
                        color: Colors.blue,
                      ),
                      Text(
                        'Review',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ],
              ),
              Image(
                image: AssetImage('asset/images/video.jpg'),
                width: 200,
                height: 102,
              ),
              LanguagesSection(),
              SpecialtiesSection(),
              SuggestedCourseSection(),
              OtherSection(
                  title: 'Interests',
                  content:
                      'I love the weather, the scenery and the laid-back lifestyle of the locals'),
              OtherSection(
                  title: 'Teaching experience',
                  content:
                      'I have more than 10 years of teaching English experience'),
            ],
          )),
    );
  }
}
