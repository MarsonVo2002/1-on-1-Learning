import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/presentation/Teacher/teacher.dart';
import 'package:lettutor/presentation/TeacherList/HeaderSection/header_section.dart';
import 'package:lettutor/presentation/TeacherList/SearchSection/search_section.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/teacher_item.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:provider/provider.dart';

class TeacherList extends StatefulWidget {
  @override
  State<TeacherList> createState() => _TeacherList();
}

Widget Filter(
    List<String> items, BuildContext context, KeywordProvider keywordProvider) {
  List<Widget> list = [];
  for (int i = 0; i < items.length; i++) {
    list.add(ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.white70),
        onPressed: () {
          keywordProvider.copyWith(items[i]);
          Navigator.of(context).pop();
        },
        child: Text(
          items[i],
          style: const TextStyle(color: Colors.black),
        )));
  }
  return Wrap(
    spacing: 10,
    children: list,
  );
}

class _TeacherList extends State<TeacherList> {
  int pageStart = 1;
  int pageEnd = 7;

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'All',
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
    // TODO: implement build
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    KeywordProvider keywordProvider = context.watch<KeywordProvider>();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            HeaderSection(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      int count = await TutorService.GetTutorCount(
                          accessToken, pageStart, 1);
                      List<Tutor> tutor = await TutorService.GetListTutors(
                          accessToken, pageStart, count);
                      List<TutorInfo> tutorinfo = await Future.wait(tutor.map(
                          (tutor) => TutorService.GetTutorData(
                              accessToken, tutor.userId!)));
                      provider.setSearchList(tutorinfo);
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchSection()));
                    },
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.blue),
                    )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Filter"),
                          content: Filter(items, context, keywordProvider),
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
                    child: const Text(
                      'Filter',
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Recommend Tutors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 410,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.tutor_list.length,
                  itemBuilder: (context, index) {
                    TutorInfo curr = provider.tutor_list[index];
                    String s = '';
                    
                    if (keywordProvider.keyword == 'All' ||
                        keywordProvider.keyword == '') {
                      return Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TeacherItem(
                          teacher: provider.tutor_list[index],
                        ),
                      );
                    } else {
                      if(specialties.containsKey(keywordProvider.keyword))
                      {
                          s = specialties[keywordProvider.keyword];
                      }
                      if (curr.specialties!.contains(s)) {
                        return Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TeacherItem(
                            teacher: provider.tutor_list[index],
                          ),
                        );
                      } else {
                        print( curr.specialties?.split(','));
                        print(specialties);
                        return Container();
                        
                      }
                    }
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      if (pageStart > 1) {
                        setState(() {
                          pageStart = pageStart - 1;
                        });
                        List<Tutor> tutor_list =
                            await TutorService.GetListTutors(
                                accessToken, pageStart, 9);
                        List<TutorInfo> tutorinfo = await Future.wait(
                            tutor_list.map((tutor) => TutorService.GetTutorData(
                                accessToken, tutor.userId!)));

                        provider.setTutorList(tutorinfo);
                      }
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.navigate_before)),
                Text('$pageStart/$pageEnd'),
                IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      if (pageStart != pageEnd) {
                        setState(() {
                          pageStart = pageStart + 1;
                        });
                        List<Tutor> tutor_list =
                            await TutorService.GetListTutors(
                                accessToken, pageStart, 9);
                        List<TutorInfo> tutorinfo = await Future.wait(
                            tutor_list.map((tutor) => TutorService.GetTutorData(
                                accessToken, tutor.userId!)));

                        provider.setTutorList(tutorinfo);
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.navigate_next)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
