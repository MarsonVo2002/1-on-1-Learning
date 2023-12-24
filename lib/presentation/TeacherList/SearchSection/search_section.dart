import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/presentation/ResetPassword/email.dart';
import 'package:lettutor/presentation/Signup/signup.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/teacher_item.dart';
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
  List<TutorInfo> result = [];
  @override
  Widget build(BuildContext context) {
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          TextField(
            controller: name,
            onChanged: (value) {
              setState(() {
                result = provider.search_tutor
                    .where((element) => element.user!.name!=null && element.user!.name!.contains(name.text))
                    .toList();
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
          TextField(
              controller: nationality,
              onChanged: (value) {
                setState(() {
                  result = provider.search_tutor
                      .where((element) =>
                       element.user!.country!=null && element.user!.country!.contains(nationality.text))
                      .toList();
                });
              },
              decoration: const InputDecoration(
                  hintText: 'Nationality',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue)),
                  suffixIcon: Icon(Icons.flag))),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 410,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TeacherItem(
                      teacher: result[index],
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
