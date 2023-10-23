import 'package:flutter/material.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Why take this course',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding:  EdgeInsets.all(10),
          child: Text('It can be intimidating to speak with foreigner, '
          'no matter how much grammar and vocabulary you have mastered. '
          'If you have basic knowledge of English but have not spent much time speaking '
          'this course will help you ease your first English conversations.')
        ),
        Text(
          'Why will you be able to do',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding:  EdgeInsets.all(10),
          child: Text('This course covers vocabulary at the CEFR A2 level. '
          'You will build confidence while learning to speak about a '
          'variety of common, everyday topics. In addition, you will build implicit '
          'grammar knowledge as your tutor models correct answers and corrects your mistakes.')
        )

      ],
    );
  }
}
