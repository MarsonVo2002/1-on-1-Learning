import 'package:flutter/material.dart';
import 'package:lettutor/presentation/TeacherList/HeaderSection/header_section.dart';
import 'package:lettutor/presentation/TeacherList/SearchSection/search_section.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/teacher_item.dart';

class TeacherList extends StatelessWidget {
  const TeacherList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        const HeaderSection(),
        const SearchSection(),
        Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Recommended Tutors',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: TeacherItem(),
        )
      ],
    );
  }
}
