import 'package:flutter/material.dart';

class LanguagesSection extends StatelessWidget {
  const LanguagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Languages',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () {},
                  child: const Text(
                    'English',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ));
  }
}
