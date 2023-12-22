import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/user/learn_topic.dart';
import 'package:lettutor/model/user/test_preparation.dart';
import 'package:lettutor/model/user/user.dart';

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
}
