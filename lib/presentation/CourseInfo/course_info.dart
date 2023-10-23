import 'package:flutter/material.dart';
import 'package:lettutor/presentation/CourseInfo/OverviewSection/overview_section.dart';

class CourseInfo extends StatelessWidget {
  const CourseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(32),
      child: ListView(children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Basic Conversational Topic',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            )
          ],
        ),
        const Image(
          image: AssetImage('asset/images/English.jpg'),
          width: 300,
          height: 200,
        ),
        const OverviewSection(),
        const Text(
          'Experience level',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Padding(padding: EdgeInsets.all(10), child: Text('Beginner')),
        const Text(
          'Course length',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Padding(padding: EdgeInsets.all(10), child: Text('10 topic(s)')),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: const Text(
                'Discover',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ))
      ]),
    );
  }
}
