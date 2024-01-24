import 'dart:async';

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
  String start = '';
  String end = '';
  DateTime upcoming = DateTime.now();
  int index = 0;
  final jitsiMeet = JitsiMeet();
  late Timer _timer;
  late Duration _currentTime;
  int _start = 10;

  void _startTimer(BookingInfo upcoming) {
    _currentTime = DateTime.fromMillisecondsSinceEpoch(
            upcoming.scheduleDetailInfo?.startPeriodTimestamp ?? 0)
        .difference(DateTime.now());
    // _currentTime = Duration(
    //   days: difference.inDays,
    //   hours: difference.inHours,
    //   minutes: difference.inMinutes,
    //   seconds: difference.inSeconds,
    // );

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_currentTime.inSeconds == 0) {
          if (mounted) {
            setState(() {
              timer.cancel();
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _currentTime = DateTime.fromMillisecondsSinceEpoch(
                      upcoming.scheduleDetailInfo?.startPeriodTimestamp ?? 0)
                  .difference(DateTime.now());
            });
          }
        }
      },
    );
  }

  String _convertWaitingTime() {
    String negativeSign = _currentTime.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(_currentTime.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(_currentTime.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(_currentTime.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void join(String room, String token) {
    var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.lettutor.com", room: room, token: token);

    jitsiMeet.join(options);
  }

  bool IsTimeToJoin(List<BookingInfo> upcoming_classes) {
    final startTimestamp =
        upcoming_classes[0].scheduleDetailInfo?.startPeriodTimestamp ?? 0;
    final startTime = DateTime.fromMillisecondsSinceEpoch(startTimestamp);
    final now = DateTime.now();
    return now.isAfter(startTime) || now.isAtSameMomentAs(startTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AccountSessionProvider session = context.watch<AccountSessionProvider>();
    if (IsTimeToJoin(session.upcoming_classes)) {
      _timer.cancel();
    }
    if (session.upcoming_classes.isEmpty ||
        index == session.upcoming_classes.length - 1) {
      return Container(
        alignment: Alignment.center,
        color: Colors.blue,
        height: 300,
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: const Text(
          'No Upcoming Lesson',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    } else {
      upcoming = DateTime.fromMillisecondsSinceEpoch(session
              .upcoming_classes[index]
              .scheduleDetailInfo!
              .startPeriodTimestamp ??
          0);

      _startTimer(session.upcoming_classes[index]);

      start = DateFormat('yyyy-MM-dd – H:mm').format(upcoming);
      end = DateFormat('H:mm').format(DateTime.fromMillisecondsSinceEpoch(
          session.upcoming_classes[index].scheduleDetailInfo!
                  .endPeriodTimestamp ??
              0));
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
              "$start - $end",
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              'Lesson is starting in\n${_convertWaitingTime()}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  if (IsTimeToJoin(session.upcoming_classes)) {
                    String token = session
                            .upcoming_classes[index].studentMeetingLink
                            ?.split('token=')[1] ??
                        '';
                    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(token);
                    String room = jwtDecoded['room'];
                    join(room, token);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Notice"),
                              content:
                                  const Text("Lesson has not started yet."),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            ));
                  }
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
