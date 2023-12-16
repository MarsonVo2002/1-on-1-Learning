import 'package:flutter/material.dart';
import 'package:lettutor/main.dart';
import 'package:lettutor/presentation/Login/login.dart';
import 'package:lettutor/presentation/TeacherForm/teacherform.dart';
import 'package:provider/provider.dart';
Widget AvatarList(
    List<String> items, AccountSessionProvider provider, TextEditingController controller) {
  List<Widget> list = [];
  for (int i = 0; i < items.length; i++) {
    list.add(IconButton(
        icon:  Image(
              image: AssetImage(items[i]),
              width: 40,
              height: 40,
            ),
        onPressed: () {
          provider.updateAvatar(items[i]);
        },
       ));
  }
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      children: [
        Wrap(
          spacing: 10,
          children: list,
        ),
        const SizedBox(height: 10 ,),
        TextField(
           decoration: const InputDecoration(
                hintText: 'Name',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue)),
                suffixIcon: Icon(Icons.people)),
          controller: controller,
        ),
      ],
    ),
  );
}
class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountSessionProvider provider = context.watch<AccountSessionProvider>();
    List<String> items =['asset/images/avatar.png','asset/images/france.png','asset/images/avatar.png'];
    TextEditingController controller = TextEditingController();
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: Colors.black,
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      provider.user.avatar!,
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.user.name!,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(provider.user.email!)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Edit profile"),
                          content: AvatarList(items, provider, controller),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                provider.updateUsername(controller.text);
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    },
            child: Container(
            
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit profile',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                ],
              ),
            ),
          ),
           GestureDetector(
            onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => TeacherForm()
                      );
                    },
            child: Container(
            
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Teacher enrollment',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: const Text(
                  'SIGN OUT',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ))
        ],
      ),
    );
  }
}
