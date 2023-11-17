import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/presentation/Teacher/teacher.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/AvatarSection/avatar_section.dart';

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
  final TeacherDTO teacher;
  final TeacherDetailDTO detail;
  const TeacherItem({super.key, required this.teacher, required this.detail});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.black,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarSection(
              name: teacher.name,
              avatarpath: teacher.avatarpath,
              nationality: teacher.nationality,
              flagpath: teacher.flaticon,
              rating: teacher.rating,
            ),
            Specialities(detail.specialities),
            Text(detail.description),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 3, color: Colors.blue)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Teacher()));
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
