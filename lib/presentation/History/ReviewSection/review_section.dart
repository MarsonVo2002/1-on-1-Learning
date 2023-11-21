import 'package:flutter/material.dart';

class ReviewSection extends StatelessWidget
{
  final DateTime date;
  const ReviewSection({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
     DateTime endTime = date.add(Duration(minutes: 25));
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text('Lesson Time: ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().
                    padLeft(2, '0')} - ${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString()
                    .padLeft(2, '0')}'),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {},
                    child: const Text(
                      'Record',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            const Text('No request for lesson'),
            const Text('Review from session', style: TextStyle(fontSize: 20),),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all()), 
              child:  const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Text('Lesson status: completed'),
                Text('Lesson progress: completed'),
                Text('Overall comment: We finised this lesson'),
            ],),),
           
            const SizedBox(height: 10,),
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add rating', style: TextStyle(color: Colors.blue)),
                Text('Report', style: TextStyle(color: Colors.blue),),
            ],)
          ],
        ),
    );
  }

}