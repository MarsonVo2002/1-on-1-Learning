import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/schedule/schedule_info.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/presentation/Teacher/teacher.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/AvatarSection/avatar_section.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:provider/provider.dart';

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

class TeacherItem extends StatefulWidget {
  final TutorInfo teacher;

  const TeacherItem({super.key, required this.teacher});

  @override
  State<TeacherItem> createState() => _TeacherItem();
}

class _TeacherItem extends State<TeacherItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AccountSessionProvider session_provider = context.watch<AccountSessionProvider>();
    final learnTopics = session_provider.topic
          .where((topic) => widget.teacher.specialties?.split(',').contains(topic.key) ?? false)
          .map((e) => e.name ?? 'null');
      final testPreparations = session_provider.test
          .where((test) => widget.teacher.specialties?.split(',').contains(test.key) ?? false)
          .map((e) => e.name ?? 'null');
    List<String> specialties = [...learnTopics, ...testPreparations];
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(20),
        width: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.black,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarSection(
              teacher: widget.teacher,
            ),
            Container(
                height: 200,
                child: Specialities(specialties)),
            SizedBox(
              height: 48,
              child: Text(widget.teacher.bio == null ? '' : widget.teacher.bio!,
                  overflow: TextOverflow.fade, maxLines: 3),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 3, color: Colors.blue)),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      TutorInfo info = await TutorService.GetTutorData(
                          accessToken, widget.teacher.user!.id!);
                      const CircularProgressIndicator();
                      List<ScheduleInfo> schedules =
                          await BookingService.GetTutorScheduleById(
                              accessToken, widget.teacher.user!.id!);

                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Teacher(
                                    info: info,
                                    schedules: schedules,
                                  )));
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
