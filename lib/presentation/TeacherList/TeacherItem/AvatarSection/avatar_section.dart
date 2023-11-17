import 'package:flutter/material.dart';

Widget Rating(int rating) {
  List<Widget> list = [];
  for (var i = 0; i < 5; i++) {
    if (i < rating) {
      list.add(
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
      );
    }
    else{
      list.add(
        Icon(
          Icons.star,
          color: Colors.grey,
        ),
      );
    }
  }
  ;
  return Row(
    children: list,
  );
}

class AvatarSection extends StatelessWidget {
  final String name;
  final String avatarpath;
  final String nationality;
  final String flagpath;
  final int rating;
  const AvatarSection(
      {super.key,
      required this.name,
      required this.avatarpath,
      required this.nationality,
      required this.flagpath,
      required this.rating});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image(
              image: AssetImage(avatarpath),
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
                  name,
                  style: const TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Image(
                      image: AssetImage(flagpath),
                      width: 15,
                      height: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                     Text(nationality)
                  ],
                ),
                Rating(rating)
              ],
            ),
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage('asset/icons/love.png'),
              width: 20,
              height: 20,
            ))
      ],
    );
  }
}
