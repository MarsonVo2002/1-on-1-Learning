import 'dart:async';

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

Widget Filter(List<String> items) {
  List<Widget> list = [];
  bool isPressed = false;
  for (int i = 0; i < items.length; i++) {
    list.add(ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: isPressed ? Colors.blue : Colors.white70),
        onPressed: () {
          if (isPressed == false) {
            isPressed = true;
          } else {
            isPressed = false;
          }
        },
        child: Text(
          items[i],
          style: TextStyle(color: isPressed ? Colors.white : Colors.black),
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
  bool _isLoading = true;
  bool isEmpty = false;
  List<Tutor> tutor_list = [];
  List<TutorInfo> tutorinfo = [];
  String selectedIndex = '';
  int itemsPerPage = 9;
  int currentPage = 0;
  void nextPage() {
    final provider =
        Provider.of<AccountSessionProvider>(context, listen: false);
        print(provider.tutor_list.length);
    if (currentPage <
        (provider.tutor_list.length / itemsPerPage).ceil() - 1) {
      setState(() {
        currentPage++;
      });
    }
  }


  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }
  Future<void> FetchData(AccountSessionProvider provider) async {
    print(pageStart);
    final data = await TutorService.GetListTutors(accessToken, pageStart, 9);
    final result = await Future.wait(data
        .map((tutor) => TutorService.GetTutorData(accessToken, tutor.userId!)));
    if (data.isNotEmpty) {
      provider.setReview(data);
      provider.setTutorList(result);
      provider.sortTutorList();
      setState(() {
        isEmpty = false;
      });
    } else {
      isEmpty = true;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      selectedIndex = specialties.entries.first.key;
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    KeywordProvider keywordProvider = context.watch<KeywordProvider>();
    final startIndex = currentPage * itemsPerPage;
    final endIndex = (currentPage + 1) * itemsPerPage;
    // if (_isLoading) {
    //   print("Fetching");
    //   FetchData(provider);
    // }
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
                      // int count = await TutorService.GetTutorCount(
                      //     accessToken, pageStart, 1);
                      // List<Tutor> tutor = await TutorService.GetListTutors(
                      //     accessToken, pageStart, count);
                      // List<TutorInfo> tutorinfo = await Future.wait(tutor.map(
                      //     (tutor) => TutorService.GetTutorData(
                      //         accessToken, tutor.userId!)));
                      // provider.setSearchList(tutorinfo);
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

                // ElevatedButton(
                //     style:
                //         ElevatedButton.styleFrom(primary: Colors.white),
                //     onPressed: () {
                //       showDialog(
                //         context: context,
                //         builder: (context) => AlertDialog(
                //           title: const Text("Filter"),
                //           content:
                //               Filter(items),
                //           actions: <Widget>[
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.of(context).pop();
                //               },
                //               child: const Text("OK"),
                //             ),
                //           ],
                //         ),
                //       );
                //     },
                //     child: const Text(
                //       'Filter',
                //       style: TextStyle(color: Colors.blue),
                //     )),
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
              child: isEmpty
                  ? const Center(
                      child: Text("No tutors are available"),
                    )
                  // : _isLoading
                  //     ? const Center(
                  //         child: CircularProgressIndicator(),
                  //       )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:provider.tutor_list.sublist(
                              startIndex,
                              endIndex.clamp(
                                  0, provider.tutor_list.length))
                          .length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TeacherItem(
                            teacher: provider.tutor_list[index + startIndex],
                          ),
                        );
                      }),
            ),
            // _isLoading
            //     ? Container()
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: previousPage,//() {
                    //   // if (mounted) {
                    //   //   setState(() {
                    //   //     _isLoading = true;
                    //   //   });
                    //   // }
                    //   // if (_isLoading) {
                    //   //   showDialog(
                    //   //       context: context,
                    //   //       builder: (context) {
                    //   //         return const Center(
                    //   //           child: CircularProgressIndicator(),
                    //   //         );
                    //   //       });
                    //   //   await Future.delayed(const Duration(seconds: 3));
                    //   //   Navigator.pop(context);
                    //   // }
                    //   if (pageStart > 1) {
                    //     // if (mounted) {
                    //     print("first");
                    //     setState(() {
                    //       pageStart = pageStart - 1;
                    //       _isLoading = true;
                    //     });
                    //     // }
                    //     // provider.setTutorList(tutorinfo);
                    //     // provider.setReview(tutor_list);
                    //     // if (mounted) {
                    //     //   setState(() {
                    //     //     _isLoading = false;
                    //     //   });
                    //     // }
                    //   }
                    // },
                    icon: const Icon(Icons.navigate_before)),
                Text('${currentPage + 1}'),
                IconButton(
                    onPressed: nextPage,//() {
                    //   // if (mounted) {
                    //   //   setState(() {
                    //   //     _isLoading = true;
                    //   //   });
                    //   // }
                    //   // if (_isLoading) {
                    //   //   showDialog(
                    //   //       context: context,
                    //   //       builder: (context) {
                    //   //         return const Center(
                    //   //           child: CircularProgressIndicator(),
                    //   //         );
                    //   //       });
                    //   //   await Future.delayed(const Duration(seconds: 3));
                    //   //   Navigator.pop(context);
                    //   // }
                    //   // if (pageStart != pageEnd) {
                    //   // if (mounted) {
                    //   setState(() {
                    //     pageStart = pageStart + 1;
                    //     _isLoading = true;
                    //   });
                    //   // }

                    //   // List<Tutor> tutor_list =
                    //   //     await TutorService.GetListTutors(
                    //   //         accessToken, pageStart, 9);
                    //   // List<TutorInfo> tutorinfo = await Future.wait(
                    //   //     tutor_list.map((tutor) => TutorService.GetTutorData(
                    //   //         accessToken, tutor.userId!)));

                    //   // provider.setTutorList(tutorinfo);
                    //   // provider.setReview(tutor_list);
                    //   // if (mounted) {
                    //   //   setState(() {
                    //   //     _isLoading = false;
                    //   //   });
                    //   // }
                    //   // }
                    // },
                    icon: const Icon(Icons.navigate_next)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
