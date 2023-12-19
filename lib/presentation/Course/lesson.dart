import 'package:flutter/material.dart';
import 'package:lettutor/model/course/course_topic.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Lesson extends StatefulWidget {
  final List<CourseTopic> topics;

  const Lesson({super.key, required this.topics});
  @override
  State<Lesson> createState() => _Lesson();
}

class _Lesson extends State<Lesson> {
  String name = '';
  int curr_index = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
      ),
      body: name == ''
          ? SfPdfViewer.network(widget.topics[0].nameFile!)
          : SfPdfViewer.network(name),
      drawer: Drawer(
          backgroundColor: Colors.white,
          child: SafeArea(
            child: Column(
              children: [
                const Text(
                  'List Topics',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.topics.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: curr_index == index
                                ? Colors.blue
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                name = widget.topics[index].nameFile!;
                                curr_index = index;
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${index + 1}. ${widget.topics[index].name!}',
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: curr_index == index
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
