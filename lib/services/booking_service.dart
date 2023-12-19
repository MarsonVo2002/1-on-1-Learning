import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/schedule/schedule_info.dart';

class BookingService {
  static Future<List<ScheduleInfo>> GetTutorScheduleById(
      String accessToken, String id) async {
    final response = await http
        .post(Uri.parse('https://sandbox.api.lettutor.com/schedule'), headers: {
      'Authorization': 'Bearer $accessToken',
    }, body: {
      'tutorId': id,
    });

    final body = json.decode(response.body);
    final List data = body['data'];
    List<ScheduleInfo> schedules =
        data.map((schedule) => ScheduleInfo.fromJson(schedule)).toList();
    schedules = schedules.where((schedule) {
      if (schedule.startTimestamp == null) return false;
      final now = DateTime.now();
      final start =
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);
      return start.isAfter(now);
    }).toList();
    return schedules;
  }
  static Future<List<BookingInfo>> GetBookedClass( String token) async
  {
     String apiUrl = 'https://sandbox.api.lettutor.com/booking/list/student?page=1&perPage=20&dateTimeLte=${DateTime.now().millisecondsSinceEpoch}&orderBy=meeting&sortBy=desc';
    final response = await http.get(
      Uri.parse(apiUrl),

      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    final body = json.decode(response.body);
    print(body);
    final List booked_class = body['data']['rows'];
     return booked_class.map((e) => BookingInfo.fromJson(e)).toList();
  }
  static Future<void> BookClass(
    List<String> scheduleDetailIds,
    String note,
    String token,
  ) async {
    final response = await http.post(
      Uri.parse('https://sandbox.api.lettutor.com/booking'),
      headers: {
        'Content-Type': 'application/json;encoding=utf-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'scheduleDetailIds': scheduleDetailIds,
          'note': note,
        },
      ),
    );
  }
}
