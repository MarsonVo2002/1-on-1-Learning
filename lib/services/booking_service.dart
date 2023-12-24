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

  static Future<void> cancelBookedClass(
    List<String> scheduleDetailIds,
    String token,
  ) async {
    final response = await http.delete(
      Uri.parse('https://sandbox.api.lettutor.com/booking'),
      headers: {
        'Content-Type': 'application/json;encoding=utf-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'scheduleDetailIds': scheduleDetailIds,
        },
      ),
    );

    if (response.statusCode != 200) {
      print(json.decode(response.body)['message']);
    }
  }

  static Future<List<BookingInfo>> GetBookedClass(String token) async {
    // final now = DateTime.now().subtract(const Duration(minutes: 35)).millisecondsSinceEpoch;
    // String apiUrl = 'https://sandbox.api.lettutor.com/booking/list/student?page=1&perPage=20&dateTimeLte=$now&orderBy=meeting&sortBy=desc';
    // final response = await http.get(
    //   Uri.parse(apiUrl),

    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer $token'
    //   },
    // );
    // final body = json.decode(response.body);
    // print(body);
    // final List booked_class = body['data']['rows'];
    //  return booked_class.map((e) => BookingInfo.fromJson(e)).toList();
    final now = DateTime.now().millisecondsSinceEpoch;
    final response = await http.get(
      Uri.parse('https://sandbox.api.lettutor.com/booking/next?dateTime=$now'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final List<dynamic> data = jsonDecode['data'];
    List<BookingInfo> lessons =
        data.map((e) => BookingInfo.fromJson(e)).toList();
    return lessons;
    // // Sort lessons by timestamp increasingly
    // lessons.sort((a, b) {
    //   if (a.scheduleDetailInfo == null || b.scheduleDetailInfo == null) return 0;
    //   if (a.scheduleDetailInfo!.startPeriodTimestamp == null ||
    //       b.scheduleDetailInfo!.startPeriodTimestamp == null) return 0;

    //   final int timestamp1 = a.scheduleDetailInfo!.startPeriodTimestamp!;
    //   final int timestamp2 = b.scheduleDetailInfo!.startPeriodTimestamp!;

    //   return timestamp1.compareTo(timestamp2);
    // });

    // lessons = lessons.where((element) {
    //   if (element.scheduleDetailInfo == null) return false;
    //   if (element.scheduleDetailInfo!.startPeriodTimestamp == null) return false;

    //   final int startTimestamp = element.scheduleDetailInfo!.startPeriodTimestamp!;
    //   return startTimestamp > now;
    // }).toList();

    // if (lessons.isNotEmpty) {
    //   return lessons.first;
    // } else {
    //   throw Exception('Error: Cannot get next lesson info');
    // }
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
    if (response.statusCode != 200) {
      final jsonDecode = json.decode(response.body);
      throw Exception(jsonDecode['message']);
    }
  }

  static Future<List<BookingInfo>> GetHistory(String token) async {
    final now = DateTime.now()
        .subtract(const Duration(minutes: 35))
        .millisecondsSinceEpoch;
    String apiUrl =
        'https://sandbox.api.lettutor.com/booking/list/student?page=1&perPage=20&dateTimeLte=$now&orderBy=meeting&sortBy=desc';
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
}
