import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSection extends StatelessWidget {
  final DateTime date;
  const DateSection({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    String format = DateFormat.yMMMMd().format(date);
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         format,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
        ),
      ],
    );
  }
}
