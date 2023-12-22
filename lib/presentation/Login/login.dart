import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lettutor/const.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/model/account-dto.dart';
import 'package:lettutor/model/course/course.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/model/user/learn_topic.dart';
import 'package:lettutor/model/user/test_preparation.dart';
import 'package:lettutor/model/user/user.dart';
import 'package:lettutor/presentation/Login/AlternativeMethodSection/alternative_method_section.dart';
import 'package:lettutor/presentation/Login/ButtonSection/button_section.dart';
import 'package:lettutor/presentation/Login/TextFieldSection/textfield_section.dart';
import 'package:lettutor/presentation/ResetPassword/email.dart';
import 'package:lettutor/presentation/Signup/signup.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/services/course_service.dart';
import 'package:lettutor/services/login_service.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:lettutor/services/user_info_service.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AccountSessionProvider sessionProvider =
        context.watch<AccountSessionProvider>();
    void _login() async {
      String email = _emailController.text;
      String password = _passwordController.text;
      AccountDTO item = AccountDTO(email: email, password: password);
      var reponse = await LoginService.login(item);
      Map<String, dynamic> jsonData = json.decode(reponse.body);
      setState(() {
        accessToken = jsonData['tokens']['access']['token'];
      });
      User user = await UserInfoService.GetUserData(accessToken);
      List<Tutor> tutor = await TutorService.GetListTutors(accessToken, 1,9);
      List<Course> course = await CourseService.GetCourseList(accessToken);
      List<BookingInfo> info = await BookingService.GetBookedClass(accessToken);
      List<BookingInfo> history =
          await BookingService.GetBookedClass(accessToken);
      List<TutorInfo> tutorinfo = await Future.wait(tutor.map(
          (tutor) => TutorService.GetTutorData(accessToken, tutor.userId!)));
      List<TestPreparation> test  = await UserInfoService.GetTestPreparation(accessToken);
      List<LearnTopic> topic = await UserInfoService.GetLearningTopic(accessToken);
      if (reponse.statusCode == 200) {
       
        sessionProvider.setUser(user);
        sessionProvider.setAccount(item);
        sessionProvider.setTutorList(tutorinfo);
        sessionProvider.setTests(test);
        sessionProvider.setTopics(topic);
        sessionProvider.setCourseList(course);
        sessionProvider.setBookedClass(info);
        sessionProvider.setHistory(history);
         List<TutorInfo> favorite = sessionProvider.tutor_list
            .where((element) => element.isFavorite == true)
            .toList();
        sessionProvider.setFavoriteList(favorite);
        sessionProvider.sortBookedClasses();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        // Show an error message
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
    }

    // TODO: implement build
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
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
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      )),
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                      )),
                      controller: _passwordController,
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
                            'Forgot password?',
                            style: TextStyle(color: Colors.blue),
                          )),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            child: const Text(
                              'LOGIN',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ))
                    ],
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Or continue with'),
                      const SizedBox(
                        height: 20,
                      ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Not a member yet?'),
                          TextButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      )
                    ]),
              ),
            ],
          )),
    );
  }
}
