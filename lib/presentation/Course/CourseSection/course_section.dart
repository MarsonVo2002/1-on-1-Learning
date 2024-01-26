import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/course-dto.dart';
import 'package:lettutor/model/course/course.dart';
import 'package:lettutor/presentation/CourseInfo/course_info.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:lettutor/services/course_service.dart';
import 'package:provider/provider.dart';

import '../../../provider/account_session_provider.dart';

Widget CourseItem(Course info, BuildContext context) {
  LanguageProvider languageProvider = context.watch<LanguageProvider>();
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.blue,
          )),
      child: Column(
        children: [
          Image.network(
            info.imageUrl!,
            errorBuilder: (context, exception, stackTrace) {
              return Container();
            },
            width: 300,
            height: 200,
          ),
          Text(
            info.name!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            info.description!,
          ),
          Text(
            '${levels[info.level]} - ${info.topics!.length} lessons',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: 3, color: Colors.blue)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseInfo(course: info)));
                  },
                  child: Text(
                    languageProvider.language.seeDetail,
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          )
        ],
      ));
}

class CourseSection extends StatefulWidget {
  const CourseSection({super.key});

  @override
  State<CourseSection> createState() => _CourseSectionState();
}

class _CourseSectionState extends State<CourseSection> {
  TextEditingController search_controller = TextEditingController();
  int pageStart = 1;
  bool _isLoading = true;
  int page = 1;
  int perPage = itemsPerPage.first;
  List<Course> courses = [];
  Future<void> FetchCourse(
      token, int page, String search, AccountSessionProvider provider) async {
    final result = await CourseService.getListCourseWithPagination(
      token,
      page,
      8,
      search,
    );
    provider.setCourseList(result);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> FetchData(AccountSessionProvider provider) async {
    final result = await CourseService.GetCourseList(accessToken, pageStart, 8);
    provider.setCourseList(result);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    LanguageProvider languageProvider = context.watch<LanguageProvider>();
    if (_isLoading) {
      FetchData(provider);
    }
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(20),
        
        child: ListView(
          children: [
            TextField(
                controller: search_controller,
                onChanged: (value) {
                  FetchCourse(
                      accessToken, page, search_controller.text, provider);
                },
                decoration:  InputDecoration(
                    hintText: languageProvider.language.Search,
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue)),
                    suffixIcon: const Icon(Icons.search))),

            const SizedBox(
              height: 30,
            ),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Expanded(flex: 2,child:SizedBox()),
            //     Expanded(
            //       flex: 3,
            //       child: Text("Courses per page")),
            //      Expanded(
            //       flex: 3,
            //        child: DropdownButtonFormField<int>(
            //                      value: perPage,
            //                      items: itemsPerPage
            //           .map((itemPerPage) => DropdownMenuItem<int>(
            //               value: itemPerPage, child: Text('$itemPerPage')))
            //           .toList(),
            //                      onChanged: (value) async {

            //         setState(() {
            //           perPage = value!;
            //           page = 1;

            //           _isLoading = true;
            //         });
            //           List<Course> course = await CourseService.GetCourseList(
            //                   accessToken, pageStart, perPage);

            //               provider.setCourseList(course);
            //                      },
            //                      icon: const Icon(
            //         Icons.keyboard_arrow_down_rounded,
            //         color: Colors.blue,
            //                      ),
            //                      decoration: InputDecoration(
            //         contentPadding:
            //             const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            //         filled: true,
            //         fillColor: Colors.blue[50],
            //         enabledBorder: const OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.transparent),
            //           borderRadius: BorderRadius.all(Radius.circular(24)),
            //         ),
            //         focusedBorder: const OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.transparent),
            //           borderRadius: BorderRadius.all(Radius.circular(24)),
            //         ),
            //                      ),
            //                    ),
            //      ),
            //      Expanded(flex: 3,child:SizedBox())
            //   ],
            // ),
            provider.course_list.isNotEmpty
                ? _isLoading
                    ? Container(
                      height: 380,
                      child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                    )
                    : Container(
                        height: 380,
                        child: ListView.builder(
                            itemCount: provider.course_list.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CourseItem(
                                    provider.course_list[index], context),
                              );
                            }),
                      )
                :  SizedBox(
                    height: 380,
                    child: Center(
                      child: Text(languageProvider.language.no_courses),
                    )),
           _isLoading? Container(): Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      // if (mounted) {
                      //   setState(() {
                      //     _isLoading = true;
                      //   });
                      // }
                      // if (_isLoading) {
                      //   showDialog(
                      //       context: context,
                      //       builder: (context) {
                      //         return const Center(
                      //           child: CircularProgressIndicator(),
                      //         );
                      //       });
                      //   await Future.delayed(const Duration(seconds: 3));
                      //   Navigator.pop(context);
                      // }
                      if (pageStart > 1) {
                        if (mounted) {
                          setState(() {
                            pageStart = pageStart - 1;
                            _isLoading = true;
                          });
                        }

                        // List<Course> course = await CourseService.GetCourseList(
                        //     accessToken, pageStart, perPage);
                        // print(pageStart);
                        // provider.setCourseList(course);
                        // if (mounted) {
                        //   setState(() {
                        //     _isLoading = false;
                        //   });
                        // }
                      }
                    },
                    icon: const Icon(Icons.navigate_before)),
                Text('$pageStart'),
                IconButton(
                    onPressed: () async {
                      // if (mounted) {
                      //   setState(() {
                      //     _isLoading = true;
                      //   });
                      // }
                      // if (_isLoading) {
                      //   showDialog(
                      //       context: context,
                      //       builder: (context) {
                      //         return const Center(
                      //           child: CircularProgressIndicator(),
                      //         );
                      //       });
                      //   await Future.delayed(const Duration(seconds: 3));
                      //   Navigator.pop(context);
                      // }
                      //  List<Course> course = await CourseService.GetCourseList(
                      //       accessToken, pageStart, perPage);

                      //   if (mounted) {
                      //   print(pageStart);
                      // if(course.isNotEmpty)
                      // {
                      setState(() {
                        pageStart = pageStart + 1;
                        _isLoading = true;
                      });
                      //    provider.setCourseList(course);
                      // }

                      // if (mounted) {
                      //   setState(() {
                      //     _isLoading = false;
                      //   });
                      // }
                      // }
                    },
                    icon: const Icon(Icons.navigate_next)),
              ],
            )
          ],
        ));
  }
}
