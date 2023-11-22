import 'package:flutter/material.dart';

class ButtonWrap extends StatefulWidget {
  final List<String> selected;
  final List<String> list;
  const ButtonWrap({super.key, required this.selected, required this.list});
  @override
  State<ButtonWrap> createState() => _ButtonWrap();
}

class _ButtonWrap extends State<ButtonWrap> {
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      spacing: 10,
      children: widget.list.map((string) {
        return ElevatedButton(
          onPressed: () {
            setState(() {
              if (widget.selected.contains(string)) {
                widget.selected.remove(string);
              } else {
                widget.selected.add(string);
              }
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              widget.selected.contains(string)
                  ? Colors.blue
                  : Colors.white,
            ),
          ),
          child: Text(
            string,
            style: TextStyle(
              color: widget.selected.contains(string)
                  ? Colors.white
                  : Colors.blue,
            ),
          ),
        );
      }).toList(),
    );
  }
}
