import 'package:flutter/material.dart';
import 'package:lettutor/TeacherList/TeacherItem/AvatarSection/avatar_section.dart';

class TeacherItem extends StatelessWidget {
  const TeacherItem({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.black,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const  AvatarSection(
                name: 'Keeran',
                avatarpath: 'asset/images/avatar.png',
                nationality: 'France',
                flagpath: 'asset/images/france.png'),
            Wrap(
              direction: Axis.horizontal,
              spacing: 2,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {},
                    child: const Text(
                      'English for Business',
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {},
                    child: const Text(
                      'Conversational',
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {},
                    child: const Text(
                      'English for kids',
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {},
                    child: const Text(
                      'IELTS',
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {},
                    child: const Text(
                      'TOEIC',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            const Text(
                'I am passionate about running and fitness, I often compete in '
                'trail/mountain running events and I love pushing myself. I am '
                'training to one day take part in ultra-endurance events. I also '
                'enjoy watching rugbyon the weekends, reading and watchin... '),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 3, color: Colors.blue)),
                    onPressed: () {},
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
