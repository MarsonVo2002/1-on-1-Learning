import 'package:flutter/material.dart';

class ButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Forgot password?',
                style: TextStyle(color: Colors.blue)),
            SizedBox(width: double.infinity,child: ElevatedButton(
                  onPressed: () {},
                 
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                   
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ))
          ],
        ));
  }
}
