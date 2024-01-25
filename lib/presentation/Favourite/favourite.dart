import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/teacher_item.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:provider/provider.dart';

class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountSessionProvider session = context.watch<AccountSessionProvider>();
    LanguageProvider languageProvider = context.watch<LanguageProvider>();
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            languageProvider.language.favorite,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: session.favorite.isNotEmpty
            ? Center(
                child: SizedBox(
                  height: 430,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: session.favorite.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: TeacherItem(
                              teacher: session.favorite[index],
                            ));
                      }),
                ),
              )
            : const Center(
                child: Text('Please add teacher to your favorite lists'),
              ));
  }
}
