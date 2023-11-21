import 'package:lettutor/model/teacher-dto.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ClassInfo 
{
  final DateTime selectedDay;
  final TeacherDTO teacher;
  
  ClassInfo({required this.selectedDay, required this.teacher});
}