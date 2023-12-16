import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor/model/course/course.dart';
class CourseService
{
  static Future<List<Course>> GetCourseList(String token) async {
    String apiUrl = 'https://sandbox.api.lettutor.com/course?page=1&size=100';
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
}