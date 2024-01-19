import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class HeaderSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HeaderSection();
}

class _HeaderSection extends State<HeaderSection> {

  String date = '';
  DateTime upcoming = DateTime.now();
  int index = 0;
  final jitsiMeet = JitsiMeet();
  void join(String room, String token) {
    var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.lettutor.com", room: room, token: token);
    jitsiMeet.join(options);
  }
  @override
  
  @override
  Widget build(BuildContext context) {
    AccountSessionProvider session = context.watch<AccountSessionProvider>();
    if (session.upcoming_classes.isEmpty || index == session.upcoming_classes.length - 1) {
      return Container(
        alignment: Alignment.center,
        color: Colors.blue,
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: const Text(
          'No Upcoming Lesson',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    } else {
      upcoming = DateTime.fromMillisecondsSinceEpoch(
          session.upcoming_classes[index].scheduleDetailInfo!.startPeriodTimestamp ??
              0);
      date = DateFormat('yyyy-MM-dd – H:mm').format(upcoming);
      return Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Upcoming Lesson',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              date,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                   String token =
                      session.upcoming_classes[index].studentMeetingLink?.split('token=')[1] ?? '';
                  Map<String, dynamic> jwtDecoded =
                      JwtDecoder.decode(token);
                   String room = jwtDecoded['room'];
                  join(room, token);
                  setState(() {
                    index++;
                  });
                  // index++;
                  // upcoming = DateTime.fromMillisecondsSinceEpoch(upcoming_classes[index]
                  //         .scheduleDetailInfo!
                  //         .startPeriodTimestamp ??
                  //     0);
                  // date =
                  //     DateFormat('yyyy-MM-dd – H:mm').format(upcoming);

                  // session.addHistory(session.account.lesson_list[0]);
                  // session.removeLesson(session.account.lesson_list[0]);
                  // historyprovider.add(classinfoprovider.list[0]);
                  // classinfoprovider.remove(classinfoprovider.list[0]);
                },
                child: const Text(
                  'Enter lesson',
                  style: TextStyle(color: Colors.blue),
                )),
            Text(
              'Total lesson time ${session.account.totalLessonTime} minutes',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      );
    }
    // TODO: implement build
  }
}
