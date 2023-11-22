import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/presentation/Teacher/teacher.dart';
import 'package:lettutor/presentation/TeacherForm/ButtonWrap/button_wrap.dart';
import 'package:lettutor/presentation/TeacherForm/IconButtonWrap/icon_button_wrap.dart';
import 'package:lettutor/presentation/TeacherForm/Schedule/schedule_wrap.dart';
import 'package:provider/provider.dart';

class TeacherForm extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController interests = TextEditingController();
  TextEditingController experience = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    TeacherProvider provider = context.watch<TeacherProvider>();
    List<String> avatars = [
      'asset/images/avatar.png',
      'asset/icons/mobilephone.png',
      'asset/icons/google.png'
    ];
    List<String> flags = ['asset/images/france.png'];
    List<String> flagpath = [];
     List<String> avatarpath = [];
    List<String> suggested_course = [];
    List<String> courses = [
      'Basic Conversation Topics',
      'Life in the Internet Age',
      'IELTS Speaking Course',
      'IELTS Writing Course',
      'TOEIC Training'
    ];
    List<int> dates = [
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
      DateTime.saturday,
      DateTime.sunday
    ];
    List<int> selectedDay = [];
    List<String> language = [];
    List<String> languages = ['English', 'Spanish', 'Japanese', 'Chinese'];
    List<String> specialities = [];
    List<String> all_specialities = [
      'English for kids',
      'English for Business',
      'Conversational',
      'STARTERS',
      'MOVERS',
      'FLYERS',
      'KET',
      'PET',
      'IELTS',
      'TOELF',
      'TOEIC',
    ];
    List<String> time = [];
    List<String> timetable = [
      '18:00',
      '18:30',
      '19:00',
      '19:30',
      '20:00',
      '20:30',
      '21:00',
      '21:30',
      '22:00',
      '22:30',
    ];
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'Avatar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButtonWrap(list: avatars, selected: avatarpath),
            const Text(
              'Flag',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButtonWrap(list: flags, selected: flagpath),
            const Text('Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ScheduleWrap(selected: selectedDay, list: dates),
            const Text(
              'Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
                alignment: Alignment.center,
                child: ButtonWrap(
                  list: timetable,
                  selected: time,
                )),
            const Text('Specialities',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Container(
                alignment: Alignment.center,
                child: ButtonWrap(
                  list: all_specialities,
                  selected: specialities,
                )),
            const Text('Languages',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Container(
                alignment: Alignment.center,
                child: ButtonWrap(
                  list: languages,
                  selected: language,
                )),
            const Text('Suggested course',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Container(
                alignment: Alignment.center,
                child: ButtonWrap(
                  list: courses,
                  selected: suggested_course,
                )),
            const Text('Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.blue),
              )),
              controller: name,
            ),
            const Text('Nationality',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.blue),
              )),
              controller: nationality,
            ),
            const Text('Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.blue),
              )),
              controller: description,
            ),
            const Text('Interests',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.blue),
              )),
              controller: interests,
            ),
            const Text('Teaching experience',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.blue),
              )),
              controller: experience,
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 3, color: Colors.blue)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 3, color: Colors.blue)),
                    onPressed: () {
                      print(avatarpath);
                      print(flagpath);
                      TeacherDTO teacher = TeacherDTO(
                        id: provider.teacherlist.length + 1, 
                        name: name.text, 
                        avatarpath: avatarpath[0], 
                        flaticon: flagpath[0], 
                        nationality: nationality.text, 
                        rating: 0, 
                        detail: TeacherDetailDTO(
                          description: description.text, 
                          specialities: specialities), 
                        schedule: selectedDay, 
                        time: time, 
                        isBook: List<bool>.filled(selectedDay.length, false, growable: true), 
                        review: [], 
                        languages: languages, 
                        suggested_course: suggested_course, 
                        interests: interests.text, 
                        experience: experience.text, 
                        video: 'asset/images/video.jpg');
                      provider.add(teacher);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
