import 'package:flutter/material.dart';
import 'package:lettutor/model/calendar-dto.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/presentation/Teacher/Calendar/calendar.dart';
import 'package:lettutor/presentation/Teacher/Chat/chat.dart';
import 'package:lettutor/presentation/Teacher/LanguagesSection/languages_section.dart';
import 'package:lettutor/presentation/Teacher/OtherSection/other_section.dart';
import 'package:lettutor/presentation/Teacher/SpecialtiesSection/specialties_section.dart';
import 'package:lettutor/presentation/Teacher/SuggestedCourseSection/suggested_course_section.dart';
import 'package:lettutor/presentation/TeacherList/TeacherItem/AvatarSection/avatar_section.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// class MyDataTable extends StatelessWidget {
//   // Dummy data for demonstration
//   final TeacherDTO teacher;
//   MyDataTable({required this.teacher});
  
//   // Function to determine if a button should be shown in a specific cell
//   bool shouldShowButton(String day, String time, int index) {
//     Calendar result = Calendar(day: day, index: index, time: time);
//     return teacher.schedule.contains(result);
//   }
//   DateTime calculateDate(int date)
//   {
//     DateTime today = DateTime.now();
//     while(today.weekday!=date)
//     {
//       today = today.add(Duration(days: 1));
//     }
//     return today;
//   }
//   @override
//   Widget build(BuildContext context) {
//     final List<String> daysOfWeek = [
//     'Mon',
//     'Tue',
//     'Wed',
//     'Thu',
//     'Fri',
//     'Sat',
//     'Sun'
//   ];
//   final List<String> timesOfDay = [
//     '17:30',
//     '18:00',
//     '18:30',
//     '19:00',
//     '19:30',
//     '20:00',
//     '20:30',
//     '21:00',
//     '21:30',
//     '22:00'
//   ];
//     return Container(
//       height: 550,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           DataTable(
//             border: TableBorder.all(),
//             columns: <DataColumn>[
//               DataColumn(label: Text('Time')),
//               for (var day in daysOfWeek) DataColumn(label: Text(day)),
//             ],
//             rows: List<DataRow>.generate(
//               timesOfDay.length,
//               (int timeIndex) => DataRow(
//                 cells: <DataCell>[
                 
//                   DataCell(Text(timesOfDay[timeIndex])), // Row header (time)
//                   for (var dayIndex in daysOfWeek.asMap().keys)
//                     DataCell(
   
//                       // Conditionally show a button based on the shouldShowButton function
//                       shouldShowButton(
//                               daysOfWeek[dayIndex], timesOfDay[timeIndex], dayIndex + 1)
//                           ? ElevatedButton(
//                               style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                               onPressed: () {
//                                 DateTime lesson = calculateDate(dayIndex + 1);
//                                 // Action for the button in the specific cell
//                                 print(
//                                     'Button pressed for ${timesOfDay[timeIndex]} on ${lesson.day} ${lesson.month} ${lesson.year}');
//                               },
//                               child: Text('Book', style: TextStyle(color: Colors.white)),
//                             )
//                           : Container(), // Empty container for cells without a button
//                     ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class Teacher extends StatelessWidget {
  final TeacherDTO teacher;

  const Teacher({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              AvatarSection(
                teacher: teacher,
              ),
              Text(teacher.detail.description),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed:(){},
                        icon: Icon(Icons.apps_outage_outlined),
                        color: Colors.blue,
                      ),
                      Text(
                        'Report',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed:(){},
                        icon: Icon(Icons.star),
                        color: Colors.blue,
                      ),
                      Text(
                        'Review',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                   Column(
                    children: [
                      IconButton(
                        onPressed:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chat(teacher: teacher,)));
                        },
                        icon: Icon(Icons.chat),
                        color: Colors.blue,
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ],
              ),
              Image(
                image: AssetImage('asset/images/video.jpg'),
                width: 200,
                height: 102,
              ),
              LanguagesSection(),
              SpecialtiesSection(),
              SuggestedCourseSection(),
              OtherSection(
                  title: 'Interests',
                  content:
                      'I love the weather, the scenery and the laid-back lifestyle of the locals'),
              OtherSection(
                  title: 'Teaching experience',
                  content:
                      'I have more than 10 years of teaching English experience'),
              Calendar(teacher: teacher)
            ],
          )),
    );
  }
}
