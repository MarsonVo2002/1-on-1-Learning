import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/account-dto.dart';
import 'package:lettutor/model/course/course.dart';
import 'package:lettutor/model/language/english.dart';
import 'package:lettutor/model/language/language.dart';
import 'package:lettutor/model/language/vietnamese.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/model/user/learn_topic.dart';
import 'package:lettutor/model/user/test_preparation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lettutor/model/user/user.dart';
import 'package:lettutor/presentation/ResetPassword/email.dart';
import 'package:lettutor/presentation/Signup/signup.dart';
import 'package:lettutor/provider/language_provider.dart';
import 'package:lettutor/provider/theme_provider.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/services/course_service.dart';
import 'package:lettutor/services/login_service.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:lettutor/services/user_info_service.dart';
import 'package:provider/provider.dart';

import '../../provider/account_session_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email_error = '';
  String password_error = '';
  bool isLoading = false;
  bool isValid = false;
  String s = language.first;
  final _googleSignIn = GoogleSignIn();
  bool isLight = true;
  bool isEnglish = true;
  @override
  Widget build(BuildContext context) {
    AccountSessionProvider sessionProvider =
        context.watch<AccountSessionProvider>();
    LanguageProvider language_provider = context.watch<LanguageProvider>();
    void _validation() {
      final emailRegExp = RegExp(
          r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
      if (_emailController.text.isEmpty) {
        email_error = language_provider.language.emptyEmail;
        isValid = false;
      } else if (!emailRegExp.hasMatch(_emailController.text)) {
        email_error = language_provider.language.invalidEmail;
        isValid = false;
      } else {
        email_error = '';
        isValid = true;
      }

      if (_passwordController.text.isEmpty) {
        password_error = language_provider.language.emptyPassword;
        isValid = false;
      } else if (_passwordController.text.length < 6) {
        password_error = language_provider.language.passwordTooShort;
        isValid = false;
      } else {
        password_error = '';
        isValid = true;
      }
      setState(() {});
    }

    void _loadData(String accessToken) async {
      User user = await UserInfoService.GetUserData(accessToken);
      int count = await TutorService.GetTutorCount(accessToken);
      List<Tutor> tutor =
          await TutorService.GetListTutors(accessToken, 1, count);
      List<Course> course =
          await CourseService.GetCourseList(accessToken, 1, 8);
      List<BookingInfo> info =
          await BookingService.GetBookedClass(accessToken, 1, 20);
      List<BookingInfo> history =
          await BookingService.GetBookedClass(accessToken, 1, 20);
      List<TutorInfo> tutorinfo = await Future.wait(tutor.map(
          (tutor) => TutorService.GetTutorData(accessToken, tutor.userId!)));
      List<TestPreparation> test =
          await UserInfoService.GetTestPreparation(accessToken);
      List<LearnTopic> topic =
          await UserInfoService.GetLearningTopic(accessToken);
      List<BookingInfo> upcoming =
          await BookingService.GetAllUpcomingClasses(accessToken);
      List<TutorInfo> favorite =
          tutorinfo.where((element) => element.isFavorite == true).toList();
      var total = await UserInfoService.GetTotalLessonTime(accessToken);
      total_time = Duration(minutes: total);
      sessionProvider.setUser(user);
      sessionProvider.setReview(tutor);
      sessionProvider.setTutorList(tutorinfo);
      sessionProvider.setTests(test);
      sessionProvider.setTopics(topic);
      sessionProvider.setCourseList(course);
      sessionProvider.setBookedClass(info);
      sessionProvider.setHistory(history);
      sessionProvider.setUpcomingClasses(upcoming);
      sessionProvider.setFavoriteList(favorite);
      sessionProvider.sortBookedClasses();
      sessionProvider.sortUpcomingClasses();
      sessionProvider.sortTutorList();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }

    void _login() async {
      setState(() {
        isLoading = true;
      });
      String email = _emailController.text;
      String password = _passwordController.text;
      AccountDTO item = AccountDTO(email: email, password: password);
      var response = await LoginService.login(item);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        setState(() {
          accessToken = jsonData['tokens']['access']['token'];
        });
        _loadData(accessToken);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Login Failed"),
            content: const Text("Invalid email or password."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    void facebook_sign_in() async {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        String token = result.accessToken!.token;
        try {
          setState(() {
            isLoading = true;
          });

          var response = await LoginService.FacebookLogin(token);
          if (response.statusCode == 200) {
            Map<String, dynamic> jsonData = json.decode(response.body);
            setState(() {
              accessToken = jsonData['tokens']['access']['token'];
            });
            _loadData(accessToken);
          } else {
            // Show an error message
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Login Failed"),
                content: const Text("Google login failed"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
          setState(() {
            isLoading = false;
          });
        } catch (e) {
          if (mounted) {
            print('error 1');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Error Login with Facebook: ${e.toString()}')),
            );
          }
        }
      } else {
        print('error');
      }
    }

    void google_sign_in() async {
      // var user = await _googleSignIn.signIn();
      // if(user !=null)
      // {
      //   print('success');
      // }
      // else{
      //   print('error');
      // }
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final String? token = googleAuth?.accessToken;

        print(token);
        if (token != null) {
          try {
            setState(() {
              isLoading = true;
            });

            var response = await LoginService.GoogleLogin(token);
            if (response.statusCode == 200) {
              Map<String, dynamic> jsonData = json.decode(response.body);
              setState(() {
                accessToken = jsonData['tokens']['access']['token'];
              });
              _loadData(accessToken);
            } else {
              // Show an error message
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Login Failed"),
                  content: const Text("Google login failed"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            }
            setState(() {
              isLoading = false;
            });
          } catch (e) {
            if (mounted) {
              print('error 1');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Error Login with Google: ${e.toString()}')),
              );
            }
          }
        } else {
          print('null');
        }
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error Login with Google: ${e.toString()}')),
        );
      }
    }

    // TODO: implement build
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .setTheme();
                            setState(() {
                              if (isLight == true) {
                                isLight = false;
                              } else {
                                isLight = true;
                              }
                            });
                          },
                          icon: isLight
                              ? Icon(Icons.light_mode)
                              : Icon(Icons.dark_mode)),
                      IconButton(
                          onPressed: () {
                            language_provider.setLanguage();
                            setState(() {
                              if (isEnglish == true) {
                                isEnglish = false;
                              } else {
                                isEnglish = true;
                              }
                            });
                          },
                          icon: isEnglish
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
                  const Text(
                    'Say hello to your English tutors',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Become fluent faster through one on '
                    'one video chat lessons tailored to '
                    'your goals.',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              errorText:
                                  email_error.isEmpty ? null : email_error,
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.blue),
                              )),
                          controller: _emailController,
                          onChanged: ((value) {
                            _validation();
                            print(isValid);
                          }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          language_provider.language.password,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                              errorText: password_error.isEmpty
                                  ? null
                                  : password_error,
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.blue),
                              )),
                          controller: _passwordController,
                          onChanged: ((value) {
                            _validation();
                            print(isValid);
                          }),
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Email()));
                              },
                              child: Text(
                                language_provider.language.forgotPassword,
                                style: TextStyle(color: Colors.blue),
                              )),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isValid ? _login : null,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                ),
                                child: Text(
                                  language_provider.language.login,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ))
                        ],
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(language_provider.language.loginWith),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: facebook_sign_in,
                                  icon: Image.asset(
                                    'asset/icons/facebook.png',
                                    width: 40,
                                    height: 40,
                                  )),
                              IconButton(
                                  onPressed: google_sign_in,
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  '${language_provider.language.registerQuestion}?'),
                              TextButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: Text(
                                    language_provider.language.register,
                                    style: TextStyle(color: Colors.blue),
                                  ))
                            ],
                          )
                        ]),
                  ),
                ],
              ),
              isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          )),
    );
  }
}
