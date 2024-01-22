import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lettutor/model/account-dto.dart';
import 'package:lettutor/model/class-info.dart';
import 'package:lettutor/model/course-dto.dart';
import 'package:lettutor/model/course/course.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/model/tutor/tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/model/user/learn_topic.dart';
import 'package:lettutor/model/user/test_preparation.dart';
import 'package:lettutor/model/user/user.dart';
import 'package:lettutor/presentation/Course/course.dart';
import 'package:lettutor/presentation/Favourite/favourite.dart';
import 'package:lettutor/presentation/History/history.dart';
import 'package:lettutor/presentation/Login/login.dart';
import 'package:lettutor/presentation/Schedule/schedule.dart';
import 'package:lettutor/presentation/Setting/setting.dart';
import 'package:lettutor/presentation/TeacherList/teacherlist.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class KeywordProvider extends ChangeNotifier {
  String keyword = '';
  void copyWith(String word) {
    keyword = word;
    notifyListeners();
  }
}

class AccountProvider extends ChangeNotifier {
  final List<AccountDTO> accountList = [
    AccountDTO(email: 'example@gmail.com', password: '12345')
  ];
  void add(AccountDTO item) {
    accountList.add(item);
    notifyListeners();
    print('Add account into account list');
  }

  void updated(String email, String password) {
    AccountDTO updatedItem =
        accountList.firstWhere((element) => element.email == email);
    print(password);
    updatedItem = updatedItem.copyWith(password: password);
    int index = accountList.indexWhere((element) => element.email == email);
    accountList[index] = updatedItem;
    print(updatedItem.password);
    notifyListeners();
    print('Update account');
  }
}

class AccountSessionProvider extends ChangeNotifier {
  AccountDTO account = AccountDTO(email: '', password: '');
  User user = User();
  List<TutorInfo> tutor_list = [];
  List<TutorInfo> search_tutor = [];
  List<Course> course_list = [];
  List<TutorInfo> favorite =[];
  List<BookingInfo> booked_class = [];
  List<BookingInfo> history = [];
  List<TestPreparation> test = [];
  List<LearnTopic> topic = [];
  List<BookingInfo> upcoming_classes = [];
  List<Tutor> review = [];
  void setTests(List<TestPreparation> list)
  {
    test.clear();
    test = list;
    notifyListeners();
  }
  void setUpcomingClasses(List<BookingInfo> upcoming)
  {
    upcoming_classes.clear();
    upcoming_classes = upcoming;
    notifyListeners();
  }
  void setTopics(List<LearnTopic> list)
  {
    topic.clear();
    topic = list;
    notifyListeners();
  }
  void setReview(List<Tutor> tutor)
  {
    review = tutor; 
     notifyListeners();
  }
  void addHistory(ClassInfo info) {
    account.history_list.add(info);
    print('add to favourite');
    notifyListeners();
  }
  void setHistory(List<BookingInfo> info)
  {
    history.clear();
    history = info;
    notifyListeners();
  } 
  void setBookedClass(List<BookingInfo> info)
  {
    booked_class.clear();
    booked_class= info;
    notifyListeners();
  }
  void sortBookedClasses()
  {
    booked_class.sort(
      (a, b) {
        DateTime dateTimeA = DateTime.fromMillisecondsSinceEpoch(
            a.scheduleDetailInfo!.startPeriodTimestamp ?? 0);
        DateTime dateTimeB = DateTime.fromMillisecondsSinceEpoch(
            b.scheduleDetailInfo!.startPeriodTimestamp ?? 0);
        int dateComparison = dateTimeB.year.compareTo(dateTimeA.year);
        if (dateComparison == 0) {
          dateComparison = dateTimeB.month.compareTo(dateTimeA.month);
          if (dateComparison == 0) {
            dateComparison = dateTimeB.day.compareTo(dateTimeA.day);
          }
        }

        if (dateComparison == 0) {
          int timeComparison = dateTimeA.hour.compareTo(dateTimeB.hour);
          if (timeComparison == 0) {
            timeComparison = dateTimeA.minute.compareTo(dateTimeB.minute);
          }
          return timeComparison;
        }
        return dateComparison;
      },
    );
    notifyListeners();
  }
   void sortUpcomingClasses()
  {
    upcoming_classes.sort(
      (a, b) {
        DateTime dateTimeA = DateTime.fromMillisecondsSinceEpoch(
            a.scheduleDetailInfo!.startPeriodTimestamp ?? 0);
        DateTime dateTimeB = DateTime.fromMillisecondsSinceEpoch(
            b.scheduleDetailInfo!.startPeriodTimestamp ?? 0);
        int dateComparison = dateTimeA.year.compareTo(dateTimeB.year);
        if (dateComparison == 0) {
          dateComparison = dateTimeA.month.compareTo(dateTimeB.month);
          if (dateComparison == 0) {
            dateComparison = dateTimeA.day.compareTo(dateTimeB.day);
          }
        }

        if (dateComparison == 0) {
          int timeComparison = dateTimeA.hour.compareTo(dateTimeB.hour);
          if (timeComparison == 0) {
            timeComparison = dateTimeA.minute.compareTo(dateTimeB.minute);
          }
          return timeComparison;
        }
        return dateComparison;
      },
    );
    notifyListeners();
  }
  void setFavoriteList(List<TutorInfo> tutors)
  {
    favorite.clear();
    favorite = tutors;
    notifyListeners();
  }
  void addFavorite(TutorInfo tutor)
  {
    favorite.add(tutor);
    notifyListeners();
  }
  void deleteFavorite(TutorInfo tutor)
  {
    favorite.remove(tutor);
    notifyListeners();
  }
  void deleteBookedClass()
  {
    notifyListeners();
  }
  void setUser(User u)
  {
    user = u;
    notifyListeners();
  }
  void setCourseList(List<Course> course)
  {
    course_list.clear();
    course_list = course;
    notifyListeners();
  }
  void setTutorList(List<TutorInfo> tutor)
  {
    tutor_list.clear();
    tutor_list = tutor;
    notifyListeners();
  }
   void setSearchList(List<TutorInfo> tutor)
  {
    search_tutor.clear();
    search_tutor = tutor;
    notifyListeners();
  }
  void addTeacher(TeacherDTO teacher) {
    account.teacher_list.add(teacher);
    print('add to favourite');
    notifyListeners();
  }

  void removeTeacher(TeacherDTO teacher) {
    account.teacher_list.remove(teacher);
    print('remove from favourite');
    notifyListeners();
  }

  void removeHistory(ClassInfo info) {
    account.history_list.remove(info);
    print('remove from favourite');
    notifyListeners();
  }

  void addLesson(ClassInfo obj) {
    account.lesson_list.add(obj);
    account.totalLessonTime += 25;
    notifyListeners();
  }

  void removeLesson(ClassInfo obj) {
    account.lesson_list.remove(obj);
    account.totalLessonTime -= 25;
    notifyListeners();
  }

  void setAccount(AccountDTO obj) {
    account = obj;
    notifyListeners();
  }

  void updateUsername(String name) {
    account.name = name;
    notifyListeners();
  }

  void updateAvatar(String avatarpath) {
    account.avatarpath = avatarpath;
    notifyListeners();
  }
}
class ClassInfoProvider extends ChangeNotifier {
  List<ClassInfo> list = [];
  int totalLessonTime = 0;
  void add(ClassInfo obj) {
    list.add(obj);
    totalLessonTime += 25;
    notifyListeners();
  }

  void remove(ClassInfo obj) {
    list.remove(obj);
    totalLessonTime -= 25;
    notifyListeners();
  }
}

class HistoryProvider extends ChangeNotifier {
  final List<ClassInfo> list = [];
  void add(ClassInfo info) {
    list.add(info);
    print('add to favourite');
    notifyListeners();
  }

  void remove(ClassInfo info) {
    list.remove(info);
    print('remove from favourite');
    notifyListeners();
  }
}

class FavouriteProvider extends ChangeNotifier {
  final List<TeacherDTO> list = [];
  void add(TeacherDTO teacher) {
    list.add(teacher);
    print('add to favourite');
    notifyListeners();
  }

  void remove(TeacherDTO teacher) {
    list.remove(teacher);
    print('remove from favourite');
    notifyListeners();
  }
}

class CourseProvider extends ChangeNotifier {
  final List<CourseInformation> list = [
    CourseInformation(
        image: 'asset/images/English.jpg',
        topic: 'Intermediate Conversation Topics',
        short_description: 'Express your ideas and opinions',
        level: 'Intermediate',
        length: 10,
        what: 'It can be intimidating to speak with foreigner, '
            'no matter how much grammar and vocabulary you have mastered. '
            'If you have basic knowledge of English but have not spent much time speaking '
            'this course will help you ease your first English conversations.',
        why: 'This course covers vocabulary at the CEFR A2 level. '
            'You will build confidence while learning to speak about a '
            'variety of common, everyday topics. In addition, you will build implicit '
            'grammar knowledge as your tutor models correct answers and corrects your mistakes.')
  ];
}

class TeacherProvider extends ChangeNotifier {
  final List<TeacherDTO> teacherlist = [
    TeacherDTO(
        video: 'asset/images/video.jpg',
        experience: 'I have more than 10 years of teaching English experience',
        interests:
            'I love the weather, the scenery and the laid-back lifestyle of the locals',
        languages: ['English'],
        suggested_course: [
          'Basic Conversation Topics',
          'Life in the Internet Age'
        ],
        review: [
          'Very good',
          'great teacher',
          'He is a good teacher',
          'Very good',
          'great teacher',
          'He is a good teacher'
        ],
        id: 1,
        name: 'Keegan',
        avatarpath: 'asset/images/avatar.png',
        flaticon: 'asset/images/france.png',
        nationality: 'France',
        rating: 5,
        detail: TeacherDetailDTO(
          description:
              'I am passionate about running and fitness, I often compete in '
              'trail/mountain running events and I love pushing myself. I am '
              'training to one day take part in ultra-endurance events. I also '
              'enjoy watching rugbyon the weekends, reading and watchin... ',
          specialities: [
            'English for Business',
            'Conversational',
            'English for kids',
            'IELTS',
            'TOEIC',
          ],
        ),
        schedule: [
          // Calendar(day: 'Thu', index: DateTime.thursday, time: '18:00'),
          // Calendar(day: 'Wed', index: DateTime.wednesday, time: '17:30'),
          DateTime.thursday, DateTime.wednesday
        ],
        time: ['18:00', '17:30'],
        isBook: [false, false, false]),
    TeacherDTO(
        video: 'asset/images/video.jpg',
        experience: 'I have more than 10 years of teaching English experience',
        interests:
            'I love the weather, the scenery and the laid-back lifestyle of the locals',
        languages: ['English'],
        suggested_course: [
          'Basic Conversation Topics',
          'Life in the Internet Age'
        ],
        review: [],
        id: 2,
        name: 'Keryl',
        avatarpath: 'asset/images/avatar.png',
        flaticon: 'asset/images/france.png',
        nationality: 'Sweden',
        rating: 4,
        detail: TeacherDetailDTO(
          description:
              'I am passionate about running and fitness, I often compete in '
              'trail/mountain running events and I love pushing myself. I am '
              'training to one day take part in ultra-endurance events. I also '
              'enjoy watching rugbyon the weekends, reading and watchin... ',
          specialities: [
            'English for Business',
            'STARTER',
            'English for kids',
            'IELTS',
            'TOEIC',
          ],
        ),
        schedule: [
          // Calendar(day: 'Fri', index: DateTime.friday, time: '21:00'),
          // Calendar(day: 'Sat', index: DateTime.saturday, time: '19:30'),
          // Calendar(day: 'Fri', index: DateTime.friday, time: '18:00'),
          DateTime.friday, DateTime.saturday, DateTime.friday
        ],
        time: ['21:00', '19:30', '18:00'],
        isBook: [false, false, false]),
    TeacherDTO(
        video: 'asset/images/video.jpg',
        experience: 'I have more than 10 years of teaching English experience',
        interests:
            'I love the weather, the scenery and the laid-back lifestyle of the locals',
        languages: ['English'],
        suggested_course: [
          'Basic Conversation Topics',
          'Life in the Internet Age'
        ],
        id: 3,
        review: [],
        name: 'Neegan',
        avatarpath: 'asset/images/avatar.png',
        flaticon: 'asset/images/france.png',
        nationality: 'France',
        rating: 3,
        detail: TeacherDetailDTO(
          description:
              'I am passionate about running and fitness, I often compete in '
              'trail/mountain running events and I love pushing myself. I am '
              'training to one day take part in ultra-endurance events. I also '
              'enjoy watching rugbyon the weekends, reading and watchin... ',
          specialities: [
            'English for kids',
            'Conversational',
            'TOELF',
            'IELTS',
            'TOEIC',
          ],
        ),
        schedule: [
          // Calendar(day: 'Sun', index: DateTime.sunday, time: '21:00'),
          // Calendar(day: 'Tue', index: DateTime.tuesday, time: '19:30'),
          // Calendar(day: 'Mon', index: DateTime.monday, time: '18:00'),
          DateTime.sunday, DateTime.tuesday, DateTime.monday
        ],
        time: ['21:00', '19:30', '18:00'],
        isBook: [false, false, false]),
  ];
  void add(TeacherDTO obj) {
    teacherlist.add(obj);
    notifyListeners();
  }
}

class _MyApp extends State<MyApp> {
  final provider = AccountProvider();
  final teacherprovider = TeacherProvider();
  final keywordprovider = KeywordProvider();
  final courseprovider = CourseProvider();
  final favouriteprovider = FavouriteProvider();
  final classinfoprovider = ClassInfoProvider();
  final historyprovider = HistoryProvider();
  final accountsessionprovider = AccountSessionProvider();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => provider),
        ChangeNotifierProvider(create: (context) => teacherprovider),
        ChangeNotifierProvider(create: (context) => keywordprovider),
        ChangeNotifierProvider(create: (context) => favouriteprovider),
        ChangeNotifierProvider(create: (context) => classinfoprovider),
        ChangeNotifierProvider(create: (context) => historyprovider),
        ChangeNotifierProvider(create: (context) => courseprovider),
        ChangeNotifierProvider(create: (context) => accountsessionprovider)
      ],
      child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Lettutor'),
            ),
            body: Center(
              child: Login(),
            ),
          )),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int _selectedIndex = 0;
  static List<Widget> pages = [
    TeacherList(),
    Favourite(),
    Course_UI(),
    Schedule(),
    History(),
    Setting(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lettutor'),
      ),
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Course',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Schedule',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
