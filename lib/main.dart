import 'package:flutter/material.dart';
import 'package:lettutor/model/account-dto.dart';
import 'package:lettutor/model/teacher-detail-dto.dart';
import 'package:lettutor/model/teacher-dto.dart';
import 'package:lettutor/presentation/Course/course.dart';
import 'package:lettutor/presentation/History/history.dart';
import 'package:lettutor/presentation/Login/login.dart';
import 'package:lettutor/presentation/Schedule/schedule.dart';
import 'package:lettutor/presentation/TeacherList/teacherlist.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}
class KeywordProvider extends ChangeNotifier
{
  String keyword ='';
  void copyWith(String word)
  {
    keyword = word;
    notifyListeners();
  }
}
class NameProvider extends ChangeNotifier
{
  String keyword ='';
  void copyWith(String word)
  {
    keyword = word;
    notifyListeners();
  }
}
class NationalityProvider extends ChangeNotifier
{
  String keyword ='';
  void copyWith(String word)
  {
    keyword = word;
    notifyListeners();
  }
}
class SearchProvider extends ChangeNotifier
{
  String name ='';
  String nationality='';
  void copyWith(String name, String nationality)
  {
    this.name = name;
    this. nationality = nationality;
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

class TeacherProvider extends ChangeNotifier {
  final List<TeacherDTO> teacherlist = [
    TeacherDTO(
        id: 1,
        name: 'Keegan',
        avatarpath: 'asset/images/avatar.png',
        flaticon: 'asset/images/france.png',
        nationality: 'France',
        rating: 5),
    TeacherDTO(
        id: 2,
        name: 'Keryl',
        avatarpath: 'asset/images/avatar.png',
        flaticon: 'asset/images/france.png',
        nationality: 'Sweden',
        rating: 4),
    TeacherDTO(
        id: 3,
        name: 'Neegan',
        avatarpath: 'asset/images/avatar.png',
        flaticon: 'asset/images/france.png',
        nationality: 'France',
        rating: 3)
  ];
}

class TeacherDetailProvider extends ChangeNotifier {
  final List<TeacherDetailDTO> teacherlist = [
    TeacherDetailDTO(
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
        id: 1),
   TeacherDetailDTO(
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
        ], id: 2),
    TeacherDetailDTO(
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
        ], id: 3),
  ];
}

class _MyApp extends State<MyApp> {
  final provider = AccountProvider();
  final teacherprovider = TeacherProvider();
  final teacherdetailprovider = TeacherDetailProvider();
  final keywordprovider = KeywordProvider();
  final searchprovider = SearchProvider();
  final nameprovider = NameProvider();
  final nationalityprovider = NationalityProvider();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => provider),
        ChangeNotifierProvider(create: (context) => teacherprovider),
        ChangeNotifierProvider(create: (context) => teacherdetailprovider),
        ChangeNotifierProvider(create: (context) => keywordprovider),
        ChangeNotifierProvider(create: (context) => searchprovider),
        ChangeNotifierProvider(create: (context) => nameprovider),
        ChangeNotifierProvider(create: (context) => nationalityprovider),
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
  static List<Widget> pages = [TeacherList(), Course(), Schedule(), History()];
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
