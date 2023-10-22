import 'package:flutter/material.dart';

class TeacherSection extends StatelessWidget {
  final String name;
  final String avatarpath;
  final String nationality;
  final String flagpath;
  const TeacherSection(
      {super.key,
      required this.name,
      required this.avatarpath,
      required this.nationality,
      required this.flagpath});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image(
              image: AssetImage(avatarpath),
              width: 40,
              height: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Image(
                      image: AssetImage(flagpath),
                      width: 15,
                      height: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('France')
                  ],
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.chat,
                      color: Colors.blue,
                    ),
                    Text(
                      'Direct message',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
