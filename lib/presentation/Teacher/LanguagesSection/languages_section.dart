import 'package:flutter/material.dart';
import 'package:language_code/language_code.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:provider/provider.dart';
Widget Languages(List<String> item) {
  List<Widget> list = [];
  for (int i = 0; i < item.length; i++) {
    list.add(
      ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blue),
          onPressed: () {},
          child: Text(
            LanguageCodes.fromCode(
              item[i],
              orElse: () {
                return LanguageCodes.fromCode("en");
              },
            ).englishName,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
  return Wrap(direction: Axis.horizontal, spacing: 2, children: list);
}

class LanguagesSection extends StatelessWidget {
  final List<String> items;
  const LanguagesSection({super.key, required this.items});

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
              languageProvider.language.languages,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Languages(items)
          ],
        ));
  }
}
