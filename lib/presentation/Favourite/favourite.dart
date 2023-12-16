import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/teacher_item.dart';
import 'package:provider/provider.dart';

class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FavouriteProvider favouriteprovider = context.watch<FavouriteProvider>();
    AccountSessionProvider session = context.watch<AccountSessionProvider>();
    // TODO: implement build
    return Scaffold(
        body: ListView.builder(
              itemCount: session.account.teacher_list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  // child: TeacherItem(teacher: session.account.teacher_list[index],)
                  );
              }),
        );
  }
}
