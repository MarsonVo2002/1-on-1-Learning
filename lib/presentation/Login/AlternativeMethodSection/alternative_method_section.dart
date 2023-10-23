import 'package:flutter/material.dart';

class AlternativeMethodSection extends StatelessWidget {
  const AlternativeMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        const Text('Or continue with'),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'asset/icons/facebook.png',
                  width: 40,
                  height: 40,
                )),
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'asset/icons/google.png',
                  width: 40,
                  height: 40,
                )),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                'asset/icons/mobilephone.png',
                width: 40,
                height: 40,
              ),
            )
          ],
        ),
        const SizedBox(height: 20,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Not a member yet?'),
            Text(
              'Sign up',
              style: TextStyle(color: Colors.blue),
            )
          ],
        )
      ]),
    );
  }
}
