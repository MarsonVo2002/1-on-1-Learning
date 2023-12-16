import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
class TutorService
{
   static Future<TutorInfo> GetTutorData(String token, String tutorId) async {
    String apiUrl = 'https://sandbox.api.lettutor.com/tutor/$tutorId';
    final response = await http.get(
      Uri.parse(apiUrl),

      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    final body = json.decode(response.body);
    return TutorInfo.fromJson(body);
  }
  static Future<List<Tutor>> GetListTutors (String token, int pageStart) async 
  {
    String apiUrl = 'https://sandbox.api.lettutor.com/tutor/more?perPage=9&page=$pageStart';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    final body = json.decode(response.body);
    final List tutors = body['tutors']['rows'];
    return tutors.map((e) => Tutor.fromJson(e)).toList();
  }
  static Future<List<Tutor>> GetFavoriteListTutors (String token, int pageStart) async 
  {
    String apiUrl = 'https://sandbox.api.lettutor.com/tutor/more?perPage=9&page=$pageStart';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    final body = json.decode(response.body);
    final List tutors = body['tutors']['favoriteTutor'];
    print(tutors.length);
    return tutors.map((e) => Tutor.fromJson(e)).toList();
  }
}