import 'package:flutter/material.dart';

class ScheduleWrap extends StatefulWidget {
  final List<int> selected;
  final List<int> list;
  const ScheduleWrap({super.key, required this.selected, required this.list});
  @override
  State<ScheduleWrap> createState() => _ScheduleWrap();
}

class _ScheduleWrap extends State<ScheduleWrap> {
 
  List<String> date = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      spacing: 10,
      children: widget.list.map((day) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              if (widget.selected.contains(day)) {
                widget.selected.remove(day);
              } else {
                widget.selected.add(day);
              }
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              widget.selected.contains(day)
                  ? Colors.blue
                  : Colors.white,
            ),
          ),
          
          child: Text(
            date[day - 1],
            style: TextStyle(
              color: widget.selected.contains(day)
                  ? Colors.white
                  : Colors.blue,
            ),
          ),
        );
      }).toList(),
    );
  }
}
