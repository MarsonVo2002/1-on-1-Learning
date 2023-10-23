import 'package:flutter/material.dart';

class CourseSection extends StatelessWidget {
  const CourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue)),
                    suffixIcon: Icon(Icons.search))),
            const Row(
              children: [
                Text('Level: '),
                Flexible(
                  child: TextField(
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_down))),
                )
              ],
            ),
            const Row(
              children: [
                Text('Category: '),
                Flexible(
                  child: TextField(
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_down))),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Colors.black,
                    )),
                child: const Column(
                  children: [
                    Image(
                      image: AssetImage('asset/images/English.jpg'),
                      width: 300,
                      height: 200,
                    ),
                    Text(
                      'Intermediate Conversation Topics',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Express your ideas and opinions',
                    ),
                    Text(
                      'Intermediate - 10 lessons',
                    ),
                  ],
                ))
          ],
        ));
  }
}
