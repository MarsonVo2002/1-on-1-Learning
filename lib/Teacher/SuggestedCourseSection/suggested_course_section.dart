import 'package:flutter/material.dart';

class SuggestedCourseSection extends StatelessWidget {
  const SuggestedCourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suggested Course',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Basic Conversation Topics: ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('Link', style: TextStyle(color: Colors.blue),)
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Life in the Internet Age: ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('Link', style: TextStyle(color: Colors.blue),)
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}
