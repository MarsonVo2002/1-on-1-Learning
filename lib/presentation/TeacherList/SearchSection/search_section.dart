import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/presentation/ResetPassword/email.dart';
import 'package:lettutor/presentation/Signup/signup.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/teacher_item.dart';
import 'package:provider/provider.dart';

class SearchSection extends StatefulWidget {
  @override
  State<SearchSection> createState() => _SearchSection();
}

class _SearchSection extends State<SearchSection> {
  String name = 'name';
  String nationality = 'nationality';
  List<TeacherDTO> list = [];
  List<TeacherDetailDTO> list_detail = [];
  @override
  Widget build(BuildContext context) {
    TeacherProvider provider = context.watch<TeacherProvider>();
    TeacherDetailProvider detailprovider =
        context.watch<TeacherDetailProvider>();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          TextField(
            onChanged: (value) {
              setState(() {
                list.clear();
                list_detail.clear();
                name = value;
                for (int i = 0; i < provider.teacherlist.length; i++) {
                  if (provider.teacherlist[i].name.contains(name)) {
                    if (!list.contains(provider.teacherlist[i]) &&
                        list.isEmpty) {
                      list.add(provider.teacherlist[i]);
                      list_detail.add(detailprovider.teacherlist[i]);
                    } else {
                      if (!provider.teacherlist[i].name.contains(name) &&
                          list.contains(provider.teacherlist[i])) {
                        list.remove(provider.teacherlist[i]);
                        list_detail.remove(detailprovider.teacherlist[i]);
                      } else if (!list.contains(provider.teacherlist[i])) {
                        list.add(provider.teacherlist[i]);
                        list_detail.add(detailprovider.teacherlist[i]);
                      }
                    }
                  }
                }
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
              onChanged: (value) {
                setState(() {
                  list.clear();
                  list_detail.clear();
                  nationality = value;
                  for (int i = 0; i < provider.teacherlist.length; i++) {
                    if (provider.teacherlist[i].nationality
                        .contains(nationality)) {
                      if (!list.contains(provider.teacherlist[i]) &&
                          list.isEmpty) {
                        list.add(provider.teacherlist[i]);
                        list_detail.add(detailprovider.teacherlist[i]);
                      } else {
                        if (!provider.teacherlist[i].nationality
                                .contains(nationality) &&
                            list.contains(provider.teacherlist[i])) {
                          list.remove(provider.teacherlist[i]);
                          list_detail.remove(detailprovider.teacherlist[i]);
                        } else if (!list.contains(provider.teacherlist[i])) {
                          list.add(provider.teacherlist[i]);
                          list_detail.add(detailprovider.teacherlist[i]);
                        }
                      }
                    }
                  }
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
            height: 360,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TeacherItem(
                      teacher: list[index],
                      detail: list_detail[index],
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
