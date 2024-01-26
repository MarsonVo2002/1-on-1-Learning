import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/language/english.dart';
import 'package:lettutor/model/language/vietnamese.dart';
import 'package:lettutor/presentation/Login/login.dart';
import 'package:lettutor/presentation/TeacherForm/teacherform.dart';
import 'package:lettutor/presentation/UserProfile/user_profile.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:lettutor/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../provider/account_session_provider.dart';

Widget AvatarList(List<String> items, AccountSessionProvider provider,
    TextEditingController controller) {
  List<Widget> list = [];
  for (int i = 0; i < items.length; i++) {
    list.add(IconButton(
      icon: Image(
        image: AssetImage(items[i]),
        width: 40,
        height: 40,
      ),
      onPressed: () {
        provider.updateAvatar(items[i]);
      },
    ));
  }
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      children: [
        Wrap(
          spacing: 10,
          children: list,
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          decoration: const InputDecoration(
              hintText: 'Name',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.blue)),
              suffixIcon: Icon(Icons.people)),
          controller: controller,
        ),
      ],
    ),
  );
}

class Setting extends StatefulWidget {
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
   bool isLight = true;
  bool isEnglish = true;
  @override
  Widget build(BuildContext context) {
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    LanguageProvider languageProvider = context.watch<LanguageProvider>();
    ThemeProvider themeProvider = context.watch<ThemeProvider>();
    final _googleSignIn = GoogleSignIn();
    
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: [
          Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            themeProvider.setTheme();
                                
                           
                          },
                          icon: themeProvider.isLight
                              ? Icon(Icons.light_mode)
                              : Icon(Icons.dark_mode)),
                      IconButton(
                          onPressed: () {
                            languageProvider.setLanguage();
                            
                          },
                          icon: languageProvider.language.id == "English"
                              ? Container(
                                  width: 30,
                                  height: 30,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image(
                                  image: AssetImage('asset/icons/unitedstates.png'),
                                  
                                ))
                              : Container(
                                  width: 30,
                                  height: 30,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image(
                                  image: AssetImage('asset/icons/vietnam.png'),
                                 
                                )))
                      // TextButton(
                      //     onPressed: () {
                      //       Provider.of<ThemeProvider>(context,listen: false).setTheme();
                      //     },
                      //     child: const Text(
                      //       "Change theme",
                      //       style: TextStyle(color: Colors.blue),
                      //     )),
                    ],
                  ),
          Container(
            padding: EdgeInsets.all(15),
           
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            imageUrl: provider.user.avatar ?? '',
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
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.user.name!,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(provider.user.email!)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile(user: provider.user,)),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    languageProvider.language.edit_profile,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
         
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                 _googleSignIn.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child:  Text(
                  languageProvider.language.sign_out,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ))
        ],
      ),
    );
  }
}
