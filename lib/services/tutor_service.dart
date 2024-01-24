import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';

class TutorService {
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
   static Future<List<Tutor>> SearchTutor(
    String token,
    String search,
     int page,
     int perPage,
     Map<String, bool> nationality,
     List<String> specialties,
  ) async {
    final response = await http.post(
      Uri.parse('https://sandbox.api.lettutor.com/tutor/search'),
      headers: {
        'Content-Type': 'application/json;encoding=utf-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'page': page,
        'perPage': perPage,
        'search': search,
        'filters': {
          'specialties': specialties,
          'nationality': nationality,
        },
      }),
    );

    final body = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception(body['message']);
    }

    final List<dynamic> tutors = body['rows'];

    return  tutors.map((tutor) => Tutor.fromJson(tutor)).toList();
  }
  static Future<int> GetTutorCount(String token) async {
    String apiUrl =
        'https://sandbox.api.lettutor.com/tutor/more?perPage=9&page=1';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    final body = json.decode(response.body);
    final int count = body['tutors']['count'];
    return count;
  }
  static Future<List<Tutor>> GetListTutors(String token, int pageStart,int perPage) async {
    String apiUrl =
        'https://sandbox.api.lettutor.com/tutor/more?perPage=$perPage&page=$pageStart';
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

  static Future<List<String>> GetFavoriteListTutors(
      String token, int pageStart, int perPage) async {
    String apiUrl =
        'https://sandbox.api.lettutor.com/tutor/more?perPage=$perPage&page=$pageStart';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    final body = json.decode(response.body);
    final List data = body['favoriteTutor'];
   List<String> id = [];

     for (var item in data) {
        id.add(item['secondId']);
    
    }

   return id;
  }

  static Future<void> AddFavorite(String token, String userId) async {
    final response = await http.post(
      Uri.parse('https://sandbox.api.lettutor.com/user/manageFavoriteTutor'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'tutorId': userId,
        },
      ),
    );
  }
  static Future<void> WriteFeedback(String content, String bookingId, String userId, int rate, String token) async {
    final response = await http.post(
      Uri.parse("https://sandbox.api.lettutor.com/user/feedbackTutor"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json;encoding=utf-8",
      },
      body: json.encode({
        "content": content,
        "bookingId": bookingId,
        "userId": userId,
        "rating": rate,
      }),
    );

    if (response.statusCode != 200) {
      
      final body = json.decode(response.body);
      print(body["message"]);
    }
  }
  static Future<void> reportTutor(
     String token,
     String userId,
     String content,
  ) async {
    final response = await http.post(
      Uri.parse('https://sandbox.api.lettutor.com/report'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'tutorId': userId,
          'content': content,
        },
      ),
    );

    final body = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(body(['message']));
    }
  }
}
