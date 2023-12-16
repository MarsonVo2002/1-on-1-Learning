import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/course-dto.dart';
import 'package:lettutor/model/course/course.dart';
import 'package:lettutor/presentation/CourseInfo/course_info.dart';
import 'package:provider/provider.dart';

Widget CourseItem(Course info, BuildContext context) {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.black,
          )),
      child: Column(
        children: [
          Image.network(
            info.imageUrl!,
            errorBuilder: (context, exception, stackTrace) {
              return Container();
            },
            width: 300,
            height: 200,
          ),
          Text(
            info.name!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            info.description!,
          ),
          Text(
            '${levels[info.level]} - ${info.topics!.length} lessons',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: 3, color: Colors.blue)),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CourseInfo(course: info)));
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
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
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
                  itemCount: provider.course_list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CourseItem(provider.course_list[index], context),
                    );
                  }),
            )
          ],
        ));
  }
}
