import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/presentation/Teacher/teacher.dart';
import 'package:lettutor/presentation/TeacherList/HeaderSection/header_section.dart';
import 'package:lettutor/presentation/TeacherList/SearchSection/search_section.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/teacher_item.dart';
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
    TeacherProvider provider = context.watch<TeacherProvider>();

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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchSection()));
                    },
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.blue),
                    )),
                SizedBox(
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
            SizedBox(
              height: 10,
            ),
            Text(
              'Recommend Tutors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 360,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.teacherlist.length,
                  itemBuilder: (context, index) {
                    TeacherDTO curr = provider.teacherlist[index];

                    if (keywordProvider.keyword == 'All' ||
                        keywordProvider.keyword == '') {
                      return Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TeacherItem(
                          teacher: provider.teacherlist[index],
                        ),
                      );
                    } else {
                      if (curr.detail.specialities
                          .contains(keywordProvider.keyword)) {
                        return Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TeacherItem(
                            teacher: provider.teacherlist[index],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
