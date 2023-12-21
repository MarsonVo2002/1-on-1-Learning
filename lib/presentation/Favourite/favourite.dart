import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/teacher_item.dart';
import 'package:provider/provider.dart';

class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountSessionProvider session = context.watch<AccountSessionProvider>();
    List<TutorInfo> favorite = session.tutor_list.where((element) => element.isFavorite == true).toList();
    session.setFavoriteList(favorite);
    // TODO: implement build
    return Scaffold(
        body: ListView.builder(
              itemCount: session.favorite.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                     child: TeacherItem(teacher: session.favorite[index],)
                  );
              }),
        );
  }
}
