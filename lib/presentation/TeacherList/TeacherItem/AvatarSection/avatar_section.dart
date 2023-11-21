import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:provider/provider.dart';

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
    } else {
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
  final TeacherDTO teacher;
  const AvatarSection({required this.teacher});
  @override
  Widget build(BuildContext context) {
    FavouriteProvider provider = context.watch<FavouriteProvider>();
   
    AccountSessionProvider session_provider = context.watch<AccountSessionProvider>();
    bool isFavourite = session_provider.account.teacher_list.contains(teacher);
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image(
              image: AssetImage(teacher.avatarpath),
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
                  teacher.name,
                  style: const TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Image(
                      image: AssetImage(teacher.avatarpath),
                      width: 15,
                      height: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(teacher.nationality)
                  ],
                ),
                Rating(teacher.rating)
              ],
            ),
          ],
        ),
        IconButton(
            onPressed: () async {
              if (isFavourite) {
                session_provider.removeTeacher(teacher);
                print(isFavourite);
              } else {
                 session_provider.addTeacher(teacher);
                print(isFavourite);
              }
            },
            icon: Image(
              image: isFavourite
                  ? const AssetImage('asset/icons/fill_heart.png')
                  : const AssetImage('asset/icons/love.png'),
              width: 20,
              height: 20,
            ))
      ],
    );
  }
}
