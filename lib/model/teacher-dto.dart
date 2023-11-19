import 'package:lettutor/model/calendar-dto.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/presentation/Schedule/schedule.dart';
class TeacherDTO 
{
  final int id;
  final String name;
  final String avatarpath;
  final String flaticon;
  final String nationality;
  final int rating;
  final TeacherDetailDTO detail;
  final List<int> schedule;
  final List<String> time;
  final List<bool> isBook;
  TeacherDTO({required this.id, required this.name, 
  required this.avatarpath, required this.flaticon, 
  required this.nationality, required this.rating,
  required this.detail, required this.schedule, required this.time, required this.isBook});
}