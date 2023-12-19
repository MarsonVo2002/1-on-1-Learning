import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/model/tutor/tutor.dart';

class TeacherSection extends StatelessWidget {
  final Tutor info;
  const TeacherSection(
      {super.key, required this.info,});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.network(
              info.avatar!,
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
                  info.name!,
                  style: const TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                     CountryFlag.fromCountryCode(
                      info.country == null ? '' : info.country!,
                      height: 15,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(info.country!)
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
