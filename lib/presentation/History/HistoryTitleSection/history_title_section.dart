import 'package:flutter/material.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:provider/provider.dart';

class HistoryTitleSection extends StatelessWidget {
  const HistoryTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
     LanguageProvider languageProvider = context.watch<LanguageProvider>();
    // TODO: implement build
    return Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(10),
        child:  Row(
          children: [
            Icon(
              Icons.history,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              languageProvider.language.history,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ));
  }
}
