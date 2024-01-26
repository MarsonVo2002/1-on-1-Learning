import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:lettutor/model/calendar-dto.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/schedule/schedule_info.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/presentation/Teacher/Calendar/calendar.dart';
import 'package:lettutor/presentation/Teacher/Chat/chat.dart';
import 'package:lettutor/presentation/Teacher/LanguagesSection/languages_section.dart';
import 'package:lettutor/presentation/Teacher/OtherSection/other_section.dart';
import 'package:lettutor/presentation/Teacher/SpecialtiesSection/specialties_section.dart';
import 'package:lettutor/presentation/Teacher/SuggestedCourseSection/suggested_course_section.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/AvatarSection/avatar_section.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../provider/account_session_provider.dart';

Widget ReviewSection(String url, String content, int rating, String name) {
  return Row(
    children: [
      CachedNetworkImage(
        height: 40,
        width: 40,
        imageUrl: url,
        fit: BoxFit.cover,
        errorWidget: (context, error, stackTrace) => const Icon(
          Icons.error_outline_rounded,
          color: Colors.red,
          size: 32,
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          RatingBar.builder(
              initialRating: rating.toDouble(),
              minRating: 0,
              maxRating: 5,
              allowHalfRating: false,
              direction: Axis.horizontal,
              itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
              onRatingUpdate: (rating) {}),
          Text(content)
        ],
      )
    ],
  );
}

Widget Time(List<ScheduleInfo> items, BuildContext context,
    AccountSessionProvider tutor) {
  List<Widget> list = [];
  for (int i = 0; i < items.length; i++) {
    list.add(ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.white70),
        onPressed: () {
          items[i].isBooked!
              ? showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        scrollable: true,
                        title:  Text(Provider.of<LanguageProvider>(context).language.notice),
                        content:  Center(child: Text(Provider.of<LanguageProvider>(context).language.already_book)),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ))
              : showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    scrollable: true,
                    title:  Text(Provider.of<LanguageProvider>(context).language.booking_confirm),
                    content: Text(
                        '${Provider.of<LanguageProvider>(context).language.booking_question}${DateTime.fromMillisecondsSinceEpoch(items[i].startTimestamp!)}'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Back"),
                      ),
                      TextButton(
                        onPressed: () async {
                          print(items[i].scheduleDetails?.first.id);
                          await BookingService.BookClass(
                              [items[i].scheduleDetails?.first.id ?? ''],
                              '',
                              accessToken);
                          items[i].isBooked = true;
                          List<BookingInfo> upcoming_classes =
                              await BookingService.GetAllUpcomingClasses(
                                  accessToken);
                          tutor.setUpcomingClasses(upcoming_classes);
                          tutor.sortUpcomingClasses();
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
        },
        child: Text(
          '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(items[i].startTimestamp ?? 0))} - ${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(items[i].endTimestamp ?? 0))}',
          style: const TextStyle(color: Colors.black),
        )));
  }
  return Wrap(
    spacing: 2,
    children: list,
  );
}

Widget Date(List<DateTime> item, BuildContext context,
    List<ScheduleInfo> schedules, AccountSessionProvider tutor) {
  List<Widget> list = [];
  for (int i = 0; i < item.length; i++) {
    list.add(
      ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blue),
          onPressed: () async {
            List<ScheduleInfo> times = schedules.where(
              (element) {
                DateTime e = DateTime.fromMillisecondsSinceEpoch(
                    element.startTimestamp ?? 0);
                if (e.day == item[i].day &&
                    e.month == item[i].month &&
                    e.year == item[i].year) {
                  return true;
                } else {
                  return false;
                }
              },
            ).toList();
            times
                .sort((a, b) => a.startTimestamp!.compareTo(b.startTimestamp!));
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                scrollable: true,
                title: const Text("Time"),
                content: Time(times, context, tutor),
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
          child: Text(
            DateFormat('yyyy-MM-dd').format(item[i]),
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
  return Wrap(direction: Axis.horizontal, spacing: 5, children: list);
}

class Teacher extends StatefulWidget {
  final TutorInfo info;

  final List<ScheduleInfo> schedules;
  const Teacher({super.key, required this.info, required this.schedules});

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  VideoPlayerController? VideoController;
  ChewieController? controller;
  bool hasError = false;
  TextEditingController controller1 = TextEditingController();
  String report = '';
  @override
  void initState() {
    super.initState();
    setState(() {
      VideoController =
          VideoPlayerController.networkUrl(Uri.parse(widget.info.video ?? ''));
      controller = ChewieController(
        videoPlayerController: VideoController!,
        autoPlay: true,
        errorBuilder: (context, errorMessage) {
          return Container();
        },
      );
    });
  }

  @override
  void dispose() {
    VideoController?.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    Tutor review = provider.review
        .firstWhere((element) => element.userId == widget.info.user!.id);
    List<DateTime> timetable = widget.schedules
        .map((e) => DateTime.fromMillisecondsSinceEpoch(e.startTimestamp ?? 0))
        .toList();
    timetable = timetable
        .map(
            (dateTime) => DateTime(dateTime.year, dateTime.month, dateTime.day))
        .toSet()
        .toList();
    timetable.sort();
    for (int i = 0; i < timetable.length; i++) {
      print(timetable[i]);
    }
    final learnTopics = provider.topic
          .where((topic) => widget.info.specialties?.split(',').contains(topic.key) ?? false)
          .map((e) => e.name ?? 'null');
      final testPreparations = provider.test
          .where((test) => widget.info.specialties?.split(',').contains(test.key) ?? false)
          .map((e) => e.name ?? 'null');
    List<String> specialties = [...learnTopics, ...testPreparations];
    LanguageProvider languageProvider = context.watch<LanguageProvider>();
    // TODO: implement build
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              AvatarSection(
                teacher: widget.info,
              ),
              Text(widget.info.bio!),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(languageProvider.language.report),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 72,
                                    height: 72,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: provider.user.avatar ?? '',
                                      fit: BoxFit.cover,
                                      errorWidget:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                        Icons.error_outline_rounded,
                                        color: Colors.red,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.user.name!,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(provider.user.email!)
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 80,
                                child: TextField(
                                  controller: controller1,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 3,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      hintText:
                                          languageProvider.language.report,
                                      contentPadding: const EdgeInsets.all(12),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('NO'),
                            ),
                            TextButton(
                              onPressed: () async {
                                setState(() {
                                  report = controller1.text;
                                });
                                await TutorService.reportTutor(
                                    accessToken, provider.user.id!, report);
                                Navigator.pop(context);
                              },
                              child: const Text('YES'),
                            ),
                          ],
                        );
                      });
                        },
                        icon: Icon(Icons.apps_outage_outlined),
                        color: Colors.blue,
                      ),
                      Text(
                        languageProvider.language.report,
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) =>  AlertDialog(
                          //       scrollable: true,
                          //       title: const Text("Review"),
                          //       content:
                          //           ReviewSection(teacher),
                          //       actions: <Widget>[
                          //         TextButton(
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //           child: const Text("OK"),
                          //         ),
                          //       ],
                          //     ),

                          // );
                        },
                        icon: Icon(Icons.star),
                        color: Colors.blue,
                      ),
                      Text(
                       languageProvider.language.review,
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Chat(
                          //               teacher: widget.info,
                          //             )));
                        },
                        icon: Icon(Icons.chat),
                        color: Colors.blue,
                      ),
                      Text(
                       languageProvider.language.chat,
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: controller == null
                    ? const Text(
                        "No introduction video",
                        style: TextStyle(color: Colors.white),
                      )
                    : Chewie(controller: controller!),
              ),
              LanguagesSection(items: widget.info.languages!.split(',')),
              SpecialtiesSection(items:specialties),
              // SuggestedCourseSection(),
              OtherSection(title: languageProvider.language.interest, content: widget.info.interests!),
              OtherSection(
                  title: languageProvider.language.exp,
                  content: widget.info.experience!),
              Container(
                padding: const EdgeInsets.all(10),
                child:  Text(
                  languageProvider.language.book,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.schedules.isNotEmpty?
                  Date(timetable, context, widget.schedules, provider):Center(child: Text(languageProvider.language.no_classes),)
                ],
              ),
               Container(
                padding: const EdgeInsets.all(10),
                child:  Text(
                  languageProvider.language.review,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 300,
                child: review.feedbacks!.isNotEmpty
                    ? ListView.builder(
                      itemCount: review.feedbacks!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: ReviewSection(
                              review.feedbacks![index].firstInfo!.avatar!,
                              review.feedbacks![index].content!,
                              review.feedbacks![index].rating!,
                              review.feedbacks![index].firstInfo!.name!),
                        );
                      })
                    : Center(child: Text(languageProvider.language.no_review)),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child:  Text(
                          languageProvider.language.back,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )),
                    ],
                  )),
            ],
          )),
    );
  }
}
