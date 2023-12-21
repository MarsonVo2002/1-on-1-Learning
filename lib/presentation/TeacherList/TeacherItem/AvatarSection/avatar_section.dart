import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
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
  final TutorInfo teacher;
  const AvatarSection({required this.teacher});
  @override
  Widget build(BuildContext context) {
    AccountSessionProvider session_provider =
        context.watch<AccountSessionProvider>();
    bool isFavourite = session_provider.favorite.contains(teacher);
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            teacher.user!.avatar == null
                ? Container()
                : Container(
                    width: 72,
                    height: 72,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: teacher.user!.avatar ?? '',
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) => const Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red,
                        size: 32,
                      ),
                    ),
                  ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teacher.user!.name!,
                  style: const TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    CountryFlag.fromCountryCode(
                      teacher.user!.country == null ? '' :  teacher.user!.country!,
                      height: 15,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                       teacher.user!.country == null ? '' :  teacher.user!.country!,
                    )
                  ],
                ),
                Rating(teacher.rating == null ? 0 : teacher.rating!.round())
              ],
            ),
          ],
        ),
        IconButton(
            onPressed: () async {
              if (isFavourite) {
                //session_provider.removeTeacher(teacher as TeacherDTO);
                print(isFavourite);
              } else {
                //session_provider.addTeacher(teacher as TeacherDTO);
                print(isFavourite);
              }
            },
            icon: Image(
              image: teacher.isFavorite!
                  ? const AssetImage('asset/icons/fill_heart.png')
                  : const AssetImage('asset/icons/love.png'),
              width: 20,
              height: 20,
            ))
      ],
    );
  }
}
