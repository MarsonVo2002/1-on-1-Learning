import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/user/learn_topic.dart';
import 'package:lettutor/model/user/test_preparation.dart';
import 'package:lettutor/model/user/user.dart';
import 'package:async/async.dart';

class UserInfoService {
  static Future<User> GetUserData(String token) async {
    String apiUrl = 'https://sandbox.api.lettutor.com/user/info';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    final body = json.decode(response.body);

    return User.fromJson(body['user']);
  }
  // static Future<List<BookingInfo>> GetUpcomingClasses({
  //   required String token,
  //   required int page,
  //   required int perPage,
  // }) async {
  //   final now = DateTime.now().millisecondsSinceEpoch;
  //   final response = await http.get(
  //     Uri.parse(
  //         'https://sandbox.api.lettutor.com/booking/list/student?page=$page&perPage=$perPage&dateTimeGte=$now&orderBy=meeting&sortBy=asc'),
  //     headers: {
  //       'Content-type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   final body = json.decode(response.body);
  //   print(body);
  //   final List classes = body['data']['rows'];
  //   return classes.map((schedule) => BookingInfo.fromJson(schedule)).toList();
  // }
  // static Future<List<BookingInfo>> GetHistory({
  //   required String token,
  //   required int page,
  //   required int perPage,
  // }) async {
  //   final now = DateTime.now().millisecondsSinceEpoch;
  //   final response = await http.get(
  //     Uri.parse(
  //         'https://sandbox.api.lettutor.com/booking/list/student?page=$page&perPage=$perPage&dateTimeGte=$now&orderBy=meeting&sortBy=asc'),
  //     headers: {
  //       'Content-type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   final body = json.decode(response.body);
  //   print(body);
  //   final List classes = body['data']['rows'];
  //   return classes.map((schedule) => BookingInfo.fromJson(schedule)).toList();

  // }
  static Future<List<LearnTopic>> GetLearningTopic(String token) async {
    final response = await http.get(
      Uri.parse('https://sandbox.api.lettutor.com/learn-topic'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final body = json.decode(response.body) as List;
    if (response.statusCode != 200) {
      throw Exception(json.decode(response.body)['message']);
    }
    return body.map((e) => LearnTopic.fromJson(e)).toList();
  }

  static Future<User> PostAvatarImage(File image, String token) async {
    // string to uri
    var uri = Uri.parse("https://sandbox.api.lettutor.com/user/uploadAvatar");
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = await http.MultipartFile.fromPath('avatar', image.path);
    request.files.add(multipartFile);
    request.headers.addAll({'Authorization': 'Bearer $token'});
    var response = await request.send();
    // listen for response
    final result = await http.Response.fromStream(response);
    var body = jsonDecode(result.body);
    return User.fromJson(body);
    // final response = await http.post(
    //   Uri.parse("https://sandbox.api.lettutor.com/user/uploadAvatar"),
    //   body: {'avatar':image},
    //    headers: {
    //     'Authorization': 'Bearer $token',
    //   },
    // );
    // final body = json.decode(response.body);
    // if (response.statusCode != 200) {
    //   throw Exception(json.decode(response.body)['message']);
    // }
  }

  static Future<List<TestPreparation>> GetTestPreparation(String token) async {
    final response = await http.get(
      Uri.parse('https://sandbox.api.lettutor.com/test-preparation'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final body = json.decode(response.body) as List;
    if (response.statusCode != 200) {
      throw Exception(json.decode(response.body)['message']);
    }
    return body.map((e) => TestPreparation.fromJson(e)).toList();
  }

  static Future<User?> UpdateInfo(
    String token,
    String name,
    String country,
    String birthday,
    String level,
    List<String> learnTopics,
    List<String> testPreparations,
    String studySchedule,
  ) async {
    final response = await http.put(
      Uri.parse('https://sandbox.api.lettutor.com/user/info'),
      headers: {
        'Content-Type': 'application/json;encoding=utf-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'name': name,
        'country': country,
        'birthday': birthday,
        'level': level,
        'learnTopics': learnTopics,
        'testPreparations': testPreparations,
        'studySchedule': studySchedule,
      }),
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      return null;
    }
    return User.fromJson(jsonDecode['user']);
  }
  static GetTotalLessonTime(String token) async {
    final response = await http.get(
      Uri.parse('https://sandbox.api.lettutor.com/call/total'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final body = json.decode(response.body);

    if (response.statusCode != 200) {
      print('Error');
    }

    return body['total'];
  }
}
