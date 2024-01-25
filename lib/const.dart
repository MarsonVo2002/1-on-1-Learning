String accessToken = '';
final levels = {
  '0': 'Any level',
  '1': 'Beginner',
  '2': 'High Beginner',
  '3': 'Pre-Intermediate',
  '4': 'Intermediate',
  '5': 'Upper-Intermediate',
  '6': 'Advanced',
  '7': 'Proficiency'
};
List<String> items = ["Foreign Tutor", "Vietnamese Tutor"];
List<String> language = ["English", "Tiếng Việt"];
Map<String,String> specialties = {
  'All':'',
  'English for kids': 'english-for-kids',
  'English for Business': 'business-english',
  'Conversational': 'conversational-english',
  'STARTERS': 'starters',
  'MOVERS': 'movers',
  'FLYERS': 'flyers',
  'KET': 'ket',
  'PET': 'pet',
  'IELTS': 'ielts',
  'TOELF': 'toefl',
  'TOEIC': 'toeic',
};
Duration total_time = const Duration(minutes: 2);
String base_url = "https://sandbox.api.lettutor.com/";
const itemsPerPage = [
  5,
  10,
  15,
  20,
  25,
  50,
  100,
];
