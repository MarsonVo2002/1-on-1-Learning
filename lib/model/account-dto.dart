import 'package:lettutor/model/class-info.dart';
import 'package:lettutor/model/teacher-dto.dart';

class AccountDTO {
  final String email;
  final String password;
  int totalLessonTime = 0;
  String name='user';
  String avatarpath = 'asset/images/avatar.png';
  List<ClassInfo> lesson_list = [];
  List<ClassInfo> history_list = [];
  List<TeacherDTO> teacher_list = [];
  AccountDTO({required this.email, required this.password});
  AccountDTO copyWith({String ?email, String? password}) {
    // TODO: implement copyWith
    return AccountDTO(
      email: email ?? this.email, 
      password: password ?? this.password);
  }
  @override
  bool operator == (Object other)=>
     identical(this, other) ||
      other is AccountDTO && runtimeType == other.runtimeType && 
      password == other.password && email == other.email;
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}