import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/user/user.dart';
import 'package:lettutor/services/user_info_service.dart';
import 'package:provider/provider.dart';

import '../../provider/account_session_provider.dart';

class UserProfile extends StatefulWidget {
  final User user;
  const UserProfile({super.key, required this.user});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String birthday = '';
  String country = '';
  String curr_avatar ='';
  File? avatar;
  @override
  void initState() {
    // TODO: implement initState
    birthday = widget.user.birthday ?? '';
    country = widget.user.country ?? '';
    curr_avatar = widget.user.avatar??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phonenumber = TextEditingController();
    name.text = widget.user.name ?? '';
    phonenumber.text = widget.user.phone ?? '';
    var topics = widget.user.learnTopics ?? [];
    var test = widget.user.testPreparations ?? [];
    final learnTopics = topics.map((topic) => topic.id.toString()).toList();
    final testPreparations = test.map((test) => test.id.toString()).toList();
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: curr_avatar,
                                fit: BoxFit.cover,
                                errorWidget: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.error_outline_rounded,
                                  color: Colors.red,
                                  size: 32,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.user.email!),
                              ],
                            )
                          ],
                        ),
                        IconButton(onPressed: () async{
                          final result = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if(result!=null)
                          {
                            setState(() {
                              avatar = File(result.path);
                              print(avatar!.path);
                            });
                          }
                        }, 
                        icon: const Icon(Icons.people_alt_rounded))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            child: ElevatedButton(
                          onPressed: () async {
                            DateTime? selected_day = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950, 1, 1),
                                lastDate: DateTime(2100));
                            if (selected_day != null) {
                              setState(() {
                                birthday = DateFormat('yyyy-MM-dd')
                                    .format(selected_day);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: Text(
                            'Birthday: $birthday',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        )),
                        SizedBox(
                            child: ElevatedButton(
                          onPressed: () {
                            showCountryPicker(
                                context: context,
                                onSelect: (Country e) {
                                  setState(() {
                                    country = e.countryCode;
                                  });
                                });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: Text(
                            'Country: $country',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ))
                      ],
                    ),
                    const Text(
                      'Name',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      )),
                      controller: name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Phone',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      )),
                      controller: phonenumber,
                    ),
                  ],
                ),
              ),
              // ElevatedButton(onPressed: onPressed, child: Text)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )),
                  SizedBox(
                      child: ElevatedButton(
                    onPressed: () async {
                      User user = await UserInfoService.GetUserData(accessToken);
                      if(avatar!=null)
                      {
                        user = await UserInfoService.PostAvatarImage(avatar!, accessToken);
                       
                      }
                      user = (await UserInfoService.UpdateInfo(
                          accessToken,
                          name.text,
                          country,
                          birthday,
                          widget.user.level??'BEGINNER',
                          learnTopics,
                          testPreparations,
                          widget.user.studySchedule??'',
                      ))!;
                      
                      
                      provider.setUser(user);
                        setState(() {
                         curr_avatar = user.avatar??'';
                      });
                     
                      print(curr_avatar);
                       Navigator.of(context).pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ))
                ],
              )
            ],
          )),
    );
  }
}
