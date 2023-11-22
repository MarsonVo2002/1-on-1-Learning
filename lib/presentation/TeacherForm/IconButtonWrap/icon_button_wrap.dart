import 'package:flutter/material.dart';

class IconButtonWrap extends StatefulWidget {
  final List<String> selected;
  final List<String> list;
  const IconButtonWrap({super.key, required this.list, required this.selected});
  @override
  State<IconButtonWrap> createState() => _IconButtonWrap();
}

class _IconButtonWrap extends State<IconButtonWrap> {
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      spacing: 10,
      children: widget.list.map((string) {
        return IconButton(
          onPressed: () {
            setState(() {
              if(widget.selected.isEmpty)
              {
                widget.selected.add(string);
              }
              else{
                widget.selected.clear();
                widget.selected.add(string);
              }
            });
          },
          icon: Image(
            image: AssetImage(string),
            width: 40,
            height: 40,
          ),
         
        );
      }).toList(),
    );
  }
}
