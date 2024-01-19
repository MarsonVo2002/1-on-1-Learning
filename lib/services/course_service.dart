import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor/const.dart';
import 'package:lettutor/model/course/course.dart';

class CourseService {
  static Future<List<Course>> GetCourseList(String token, int page, int size) async {
    String apiUrl = 'https://sandbox.api.lettutor.com/course?page=$page&size=$size';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    final body = json.decode(response.body);
    final List courses = body['data']['rows'];
    return courses.map((e) => Course.fromJson(e)).toList();
  }

  static Future<List<Course>> getListCourseWithPagination(
    String token,
    int page,
    int size,
    String search,
  ) async {
    final response = await http.get(
      Uri.parse(
          'https://sandbox.api.lettutor.com/course?page=$page&size=$size${search.isNotEmpty ? '&q=$search' : ''}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final body = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
          'Error: Cannot get list of courses. ${body['message']}');
    }

    List<dynamic> courses = body['data']['rows'];
    return courses.map((e) => Course.fromJson(e)).toList();
  }
}
