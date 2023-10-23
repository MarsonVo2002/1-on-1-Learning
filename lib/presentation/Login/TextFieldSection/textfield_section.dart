import 'package:flutter/material.dart';

class TextFieldSection extends StatelessWidget {
  const TextFieldSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          TextField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.blue),
            )),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Password',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.blue),
            )),
          )
        ],
      ),
    );
  }
}
