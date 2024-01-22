import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:provider/provider.dart';

import '../Schedule/ScheduleItem/DateSection/date_section.dart';
import '../Schedule/ScheduleItem/TeacherSection/teacher_section.dart';
import 'HistoryTitleSection/history_title_section.dart';
import 'ReviewSection/review_section.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int page = 1;
  bool _isLoading = false;
  List<BookingInfo> history = [];
  Future<void> FetchData(int page) async {
    final result = await BookingService.GetBookedClass(accessToken, page, 20);
    setState(() {
      history = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    AccountSessionProvider session = context.watch<AccountSessionProvider>();

    // TODO: implement build
    return Scaffold(
      body: ListView(children: [
        const HistoryTitleSection(),
        const SizedBox(
          height: 20,
        ),
        Container(
            height: 400,
            padding: const EdgeInsets.all(10),
            child: session.history.isNotEmpty
                ? ListView.builder(
                    itemCount: session.history.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              DateSection(
                                  date: DateTime.fromMillisecondsSinceEpoch(
                                      session.history[index].scheduleDetailInfo!
                                              .startPeriodTimestamp ??
                                          0)),
                              SizedBox(
                                height: 10,
                              ),
                              TeacherSection(
                                  info: session
                                      .history[index]
                                      .scheduleDetailInfo!
                                      .scheduleInfo!
                                      .tutorInfo!),
                              ReviewSection(
                                startTime: DateTime.fromMillisecondsSinceEpoch(
                                    session.history[index].scheduleDetailInfo!
                                            .startPeriodTimestamp ??
                                        0),
                                endTime: DateTime.fromMillisecondsSinceEpoch(
                                    session.history[index].scheduleDetailInfo!
                                            .endPeriodTimestamp ??
                                        0),
                                info: session.history[index],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("No history"),
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () async {
                  if (mounted) {
                    setState(() {
                      _isLoading = true;
                    });
                  }
                  if (_isLoading) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.pop(context);
                  }
                  
                  if (page > 1) {
                   
                    if (mounted) {
                      setState(() {
                        page = page - 1;
                      });
                    }
                    await FetchData(page);
                    final now = DateTime.now().millisecondsSinceEpoch;
                    print(now);
                    session.setHistory(history);
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
                icon: const Icon(Icons.navigate_before)),
            Text('$page'),
            IconButton(
                onPressed: () async {
                  if (mounted) {
                    setState(() {
                      _isLoading = true;
                    });
                  }
                  if (_isLoading) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                     await Future.delayed(const Duration(seconds: 1));
                    Navigator.pop(context);
                  }
                  
                  if (mounted) {
                    print(page);
                   
                      setState(() {
                        page = page + 1;
                      });
                      await FetchData(page);
                      session.setHistory(history);
                      
                    

                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
                icon: const Icon(Icons.navigate_next)),
          ],
        )
      ]),
    );
  }
}
