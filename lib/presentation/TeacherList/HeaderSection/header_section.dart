import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

import '../../../provider/account_session_provider.dart';

class HeaderSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HeaderSection();
}

class _HeaderSection extends State<HeaderSection> {
  String start = '';
  String end = '';
  DateTime upcoming = DateTime.now();
  DateTime end_lesson = DateTime.now();
  int index = 0;
  final jitsiMeet = JitsiMeet();
  Timer? _timer;
  late Duration _currentTime;
  String ConvertTotalLessonTime() {
    if (total_time.inMinutes == 0) {
      return 'You have not attended any class';
    }
    String result = '';
    int hour = total_time.inHours;
    int minute = total_time.inMinutes - hour * 60;
    result += hour > 0 ? ' $hour ${hour > 1 ? 'hours' : 'hour'}' : '';
    result += minute > 0 ? ' $minute ${minute > 1 ? 'minutes' : 'minute'}' : '';

    return result;
  }

  void StartTimer(BookingInfo upcoming) {
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
        if (_currentTime.inSeconds <= 0) {
          if (mounted) {
            setState(() {
              Provider.of<AccountSessionProvider>(context, listen: false).removeUpcoming(upcoming);
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

  String ConvertWaitingTime() {
    String negativeSign = _currentTime.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes =
        twoDigits(_currentTime.inMinutes.remainder(60).abs());
    String twoDigitSeconds =
        twoDigits(_currentTime.inSeconds.remainder(60).abs());
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
    return now.isAfter(startTime.subtract(const Duration(minutes: 15))) ||
        now.isAtSameMomentAs(startTime.subtract(const Duration(minutes: 15)));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AccountSessionProvider session = context.watch<AccountSessionProvider>();
    LanguageProvider languageProvider = context.watch<LanguageProvider>();

    if (session.upcoming_classes.isEmpty) {
      return Container(
        alignment: Alignment.center,
        color: Colors.blue,
        height: 150,
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              languageProvider.language.no_upcoming,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              '${languageProvider.language.totalTime} ${ConvertTotalLessonTime()}',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      );
    } else {
      upcoming = DateTime.fromMillisecondsSinceEpoch(session
              .upcoming_classes[index]
              .scheduleDetailInfo!
              .startPeriodTimestamp ??
          0);
      end_lesson = DateTime.fromMillisecondsSinceEpoch(session
              .upcoming_classes[index].scheduleDetailInfo!.endPeriodTimestamp ??
          0);
      if (IsTimeToJoin(session.upcoming_classes)) {
        _timer?.cancel();
      }
      StartTimer(session.upcoming_classes[index]);

      start = DateFormat('yyyy-MM-dd – H:mm').format(upcoming);
      end = DateFormat('H:mm').format(end_lesson);
      return Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              languageProvider.language.upcoming,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              "$start - $end",
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              '${languageProvider.language.startLesson}\n${ConvertWaitingTime()}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () async {
                  if (IsTimeToJoin(session.upcoming_classes)) {
                    String token = session
                            .upcoming_classes[index].studentMeetingLink
                            ?.split('token=')[1] ??
                        '';
                    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(token);
                    String room = jwtDecoded['room'];

                    if (DateTime.now().isAfter(end_lesson) || end_lesson.isAtSameMomentAs(DateTime.now())) {
                      setState(() {
                        index += 1;
                      });
                    } else {
                      join(room, token);
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Notice"),
                              content: const Text(
                                  "Lesson has not started yet. Do you want to start the meeting now?"),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Back"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        String token = session
                                                .upcoming_classes[index]
                                                .studentMeetingLink
                                                ?.split('token=')[1] ??
                                            '';
                                        Map<String, dynamic> jwtDecoded =
                                            JwtDecoder.decode(token);
                                        String room = jwtDecoded['room'];
                                        join(room, token);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                )
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
                child: Text(
                  languageProvider.language.enterLesson,
                  style: const TextStyle(color: Colors.blue),
                )),
            Text(
              '${languageProvider.language.totalTime} ${ConvertTotalLessonTime()}',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      );
    }
  }
}
