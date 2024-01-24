import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/services/tutor_service.dart';
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

class AvatarSection extends StatefulWidget {
  final TutorInfo teacher;

  const AvatarSection({required this.teacher});

  @override
  State<AvatarSection> createState() => _AvatarSectionState();
}

class _AvatarSectionState extends State<AvatarSection> {

  @override
  Widget build(BuildContext context) {
    AccountSessionProvider session_provider =
        context.watch<AccountSessionProvider>();
    print(session_provider.favorite.contains(widget.teacher));
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            widget.teacher.user!.avatar == null
                ? Container()
                : Container(
                    width: 72,
                    height: 72,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.teacher.user!.avatar ?? '',
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
                  widget.teacher.user!.name!,
                  style: const TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    CountryFlag.fromCountryCode(
                      widget.teacher.user!.country == null
                          ? ''
                          : widget.teacher.user!.country!,
                      height: 15,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.teacher.user!.country == null
                          ? ''
                          : widget.teacher.user!.country!,
                    )
                  ],
                ),
                Rating(widget.teacher.rating == null
                    ? 0
                    : widget.teacher.rating!.round())
              ],
            ),
          ],
        ),
        IconButton(
            onPressed: () async {
              if (widget.teacher.isFavorite == false) {
                 setState(() {
                  widget.teacher.isFavorite = true;
                });
                await TutorService.AddFavorite(
                    accessToken, widget.teacher.user!.id!);
               
                session_provider.addFavorite(widget.teacher);
              } else {
                  setState(() {
                  widget.teacher.isFavorite = false;
                });
                await TutorService.AddFavorite(
                    accessToken, widget.teacher.user!.id!);
                           
                session_provider.deleteFavorite(widget.teacher);
              }
              session_provider.sortTutorList();
            },
            icon: Image(
              image: widget.teacher.isFavorite ?? false
                  ? const AssetImage('asset/icons/fill_heart.png')
                  : const AssetImage('asset/icons/love.png'),
              width: 20,
              height: 20,
            ))
      ],
    );
  }
}
