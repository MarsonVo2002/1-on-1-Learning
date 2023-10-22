import 'package:flutter/material.dart';

class DateSection extends StatelessWidget {
  const DateSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fri, 30 Sep 22',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text('1 lesson')
      ],
    );
  }
}
