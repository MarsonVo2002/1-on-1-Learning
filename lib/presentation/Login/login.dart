import 'package:flutter/material.dart';
import 'package:lettutor/presentation/Login/AlternativeMethodSection/alternative_method_section.dart';
import 'package:lettutor/presentation/Login/ButtonSection/button_section.dart';
import 'package:lettutor/presentation/Login/TextFieldSection/textfield_section.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(10),
        child:  ListView(
          children:  [
            const Text(
              'Say hello to your English tutors',
              style: TextStyle(fontSize: 30, color: Colors.blue,fontWeight: FontWeight.bold),
            ),
            const Text(
              'Become fluent faster through one on '
              'one video chat lessons tailored to '
              'your goals.',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const TextFieldSection(),
            ButtonSection(),
            const AlternativeMethodSection()
          ],
        ));
  }
}
