import 'package:flutter/material.dart';

class Lesson extends StatelessWidget {
  const Lesson({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(30),
      child: ListView(children: [
        const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('1/17'),
            Row(
              children: [
                Icon(Icons.zoom_out),
                SizedBox(
                  width: 5,
                ),
                Text('90%'),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.zoom_in)
              ],
            ),
            Row(
              children: [
                Icon(Icons.search),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.zoom_out_map),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.file_copy)
              ],
            ),
          ],
        ),
        const Image(
              image: AssetImage('asset/images/English.jpg'),
              width: 300,
              height: 200,
            ),
        const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lesson Overview',
              style: TextStyle(color: Colors.green, fontSize: 40),
            )
          ],
        ),
        const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What we will cover today',
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white70,
          ),
          padding: const EdgeInsets.all(20),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. Vocabulary:\n'
                '    categories of food;\n'
                '    names of food\n',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '2. Speaking: foods you\n'
                '    like; food you want\n'
                '    to eat\n',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '3. Grammar: Would like',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '4. Role-play: using\n'
                '    would like in food-\n'
                '    related scenarios\n',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
