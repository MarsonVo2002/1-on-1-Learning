import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/presentation/ResetPassword/email.dart';
import 'package:lettutor/presentation/Signup/signup.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/teacher_item.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:provider/provider.dart';

class SearchSection extends StatefulWidget {
  @override
  State<SearchSection> createState() => _SearchSection();
}

class _SearchSection extends State<SearchSection> {
  List<TeacherDTO> list = [];
  List<TeacherDetailDTO> list_detail = [];

  final TextEditingController name = TextEditingController();
  final TextEditingController nationality = TextEditingController();
  List<TutorInfo> search_result = [];
  String selectedIndex = specialties.keys.first;
  String s = items.first;
  int page = 1;
  bool isLoading = true;
  bool isVietnamese = false;
  List<Tutor> tutors = [];
  String keyword = '';
  List<TutorInfo> favorite = [];
  String _specialties = '';
  Future<void> SearchTutors(String accessToken, String name, bool isVietnamese,
      String specialties, AccountSessionProvider provider) async {
    List<String> list = [];
    if (specialties != '') {
      list = [specialties];
    }
    else{
      list.clear();
    }
    final data = await TutorService.SearchTutor(
      accessToken,
      name,
      page,
      9,
      {'isVietNamese': isVietnamese},
      list,
    );
    List<TutorInfo> tutorinfo = await Future.wait(data
        .map((tutor) => TutorService.GetTutorData(accessToken, tutor.userId!)));
    favorite =
        tutorinfo.where((element) => element.isFavorite == true).toList();
    provider.setFavoriteList(favorite);
    setState(() {
      search_result = tutorinfo;

      isLoading = false;
    });

    // if (_countryController.text.isEmpty) {
    //   _tutors = result;
    // } else {
    //   _tutors.clear();
    //   for (var tutor in result) {
    //     if (countryList[tutor.country] != null) {
    //       if (countryList[tutor.country]!.toLowerCase().contains(_countryController.text)) {
    //         _tutors.add(tutor);
    //       }
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    // TODO: implement build
    if (isLoading) {
      SearchTutors(accessToken, name.text, isVietnamese, _specialties, provider);
    }
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          TextField(
            controller: name,
            onChanged: (value) {
              setState(() {
                keyword = name.text;
                isLoading = true;
              });
            },
            decoration: const InputDecoration(
                hintText: 'Name',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue)),
                suffixIcon: Icon(Icons.people)),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: s,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      s = newValue;
                      if (s == 'Vietnamese Tutor') {
                        isVietnamese = true;
                      } else {
                        isVietnamese = false;
                      }
                      isLoading = true;
                    });
                  }
                },
                items: items.map((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(key),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: selectedIndex,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedIndex = newValue;
                      _specialties = specialties[selectedIndex]!;
                      isLoading = true;
                    });
                  }
                },
                items: specialties.keys.map((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(key),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 410,
            child: isLoading? const Center(child: CircularProgressIndicator()): search_result.isNotEmpty? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: search_result.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TeacherItem(
                      teacher: search_result[index],
                    ),
                  );
                }): const Center(child: Text('Sorry we can not find any tutor with this keywords')),
          ),
           isLoading? Container(): Row(
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
                      if (page > 1) {
                        if (mounted) {
                          setState(() {
                            page= page - 1;
                            isLoading = true;
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
                Text('$page'),
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
                        page = page + 1;
                        isLoading = true;
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
        ]),
      ),
    );
  }
}
