import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Upcoming Lesson',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const Text(
            'Fri, 30 Sep 22 18:30 -18:55',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: () {},
              child: const Text(
                'Enter lesson',
                style: TextStyle(color: Colors.blue),
              )),
          const Text(
            'Total lesson time is 1 hours 15 minutes',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
