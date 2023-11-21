import 'package:flutter/material.dart';
import 'package:lettutor/model/teacher-dto.dart';

class Chat extends StatefulWidget {
  final TeacherDTO teacher;
  Chat({required this.teacher});
  @override
  State<Chat> createState() => _Chat();
}

class _Chat extends State<Chat> {
  TextEditingController chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(widget.teacher.avatarpath),
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.teacher.name,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
             flex: 8,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.teacher.chat.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment:  Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            widget.teacher.chat[index],
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            //Chat box
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                        controller: chatController,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          if (!chatController.text.trim().isEmpty) {
                            widget.teacher.chat.add(chatController.text);
                          }
                          chatController.clear();
                        });
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
