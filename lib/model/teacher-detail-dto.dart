class TeacherDetailDTO
{
  final int id;
  final String description;
  final List<String> specialities;
  TeacherDetailDTO( {required this.description, required this.specialities, required this.id});
}