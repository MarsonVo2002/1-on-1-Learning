import 'package:flutter/material.dart';

class Call extends StatelessWidget {
  const Call({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey,
      child: Column(
        children: [
           const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('asset/images/avatar.png'),
                width: 80,
                height: 80,
              )
            ],
          ),
          const Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage('asset/images/myaccount.png'),
                width: 250,
                height: 250,
              )
            ],
          )),
         
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(8.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.mic_external_off,
                  color: Colors.white,
                ),
                Icon(
                  Icons.camera_indoor,
                  color: Colors.white,
                ),
                Icon(
                  Icons.screen_share,
                  color: Colors.white,
                ),
                Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
                Icon(
                  Icons.handshake_rounded,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
