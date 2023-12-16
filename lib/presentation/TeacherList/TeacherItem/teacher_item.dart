import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/presentation/Teacher/teacher.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/AvatarSection/avatar_section.dart';
import 'package:lettutor/services/tutor_service.dart';

Widget Specialities(List<String> item) {
  List<Widget> list = [];
  for (int i = 0; i < item.length; i++) {
    list.add(
      ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blue),
          onPressed: () {},
          child: Text(
            item[i],
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
  return Wrap(direction: Axis.horizontal, spacing: 2, children: list);
}

class TeacherItem extends StatelessWidget {
  final Tutor teacher;
  const TeacherItem({super.key, required this.teacher});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(20),
        width: 500,
        height: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.black,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarSection(
              teacher: teacher,
            ),
            Specialities(teacher.specialties!.split(',')),
            Expanded(child: Text(teacher.bio == null ? '':teacher.bio!, softWrap: true, maxLines: 6,)),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 3, color: Colors.blue)),
                    onPressed: () async {
                      TutorInfo info = await TutorService.GetTutorData(accessToken, teacher.userId!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Teacher(teacher: teacher, info: info,)));
                    },
                    child: const Text(
                      'Book',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            )
          ],
        ));
  }
}
