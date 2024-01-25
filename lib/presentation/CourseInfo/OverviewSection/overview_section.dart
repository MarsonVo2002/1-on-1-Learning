import 'package:flutter/material.dart';
import 'package:lettutor/model/course-dto.dart';
import 'package:lettutor/model/course/course.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:provider/provider.dart';

class OverviewSection extends StatelessWidget {
  final Course course;
  const OverviewSection({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = context.watch<LanguageProvider>();
    // TODO: implement build
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          languageProvider.language.overview,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          languageProvider.language.why,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding:  EdgeInsets.all(10),
          child: Text(course.reason!)
        ),
         Text(
         languageProvider.language.what,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding:  EdgeInsets.all(10),
          child: Text(course.purpose!)
        )

      ],
    );
  }
}
