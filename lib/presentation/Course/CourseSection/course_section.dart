import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/course-dto.dart';
import 'package:lettutor/presentation/CourseInfo/course_info.dart';
import 'package:provider/provider.dart';

Widget CourseItem(CourseInformation info, BuildContext context) {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.black,
          )),
      child: Column(
        children: [
          Image(
            image: AssetImage(info.image),
            width: 300,
            height: 200,
          ),
          Text(
            info.topic,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            info.short_description,
          ),
          Text(
            '${info.level} - ${info.length} lessons',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: 3, color: Colors.blue)),
                  onPressed: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CourseInfo(course: info)));
                  },
                  child: Text(
                    'See detail',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          )
        ],
      ));
}

class CourseSection extends StatelessWidget {
  const CourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    CourseProvider provider = context.watch<CourseProvider>();
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
              height: 300,
              child: ListView.builder(
                itemCount: provider.list.length,
                itemBuilder: (context, index)
                {
                  return CourseItem(provider.list[index], context);
                }
              ),
            )
          ],
        ));
  }
}
