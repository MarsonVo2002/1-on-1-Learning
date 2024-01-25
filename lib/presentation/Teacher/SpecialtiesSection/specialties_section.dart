import 'package:flutter/material.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:provider/provider.dart';
Widget Specialities(List<String> item) {
  List<Widget> list = [];
  for (int i = 0; i < item.length; i++) {
    list.add(
      ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blue),
          onPressed: () {},
          child: Text(
            item[i],
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
  return Wrap(direction: Axis.horizontal, spacing: 2, children: list);
}
class SpecialtiesSection extends StatelessWidget {
  final List<String>items;
  const SpecialtiesSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
     LanguageProvider languageProvider = context.watch<LanguageProvider>();
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              languageProvider.language.specialties,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child:Specialities(items),
            )
          ],
        ));
  }
}
