import 'package:flutter/material.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:provider/provider.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = context.watch<LanguageProvider>();
    // TODO: implement build
    return Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(10),
        child:  Row(
          children: [
            const Icon(
              Icons.calendar_month,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              languageProvider.language.Schedule,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ));
  }
}
