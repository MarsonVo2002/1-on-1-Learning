import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue)),
                    suffixIcon: Icon(Icons.search))),
            Wrap(
              direction: Axis.horizontal,
              spacing: 2,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {},
                    child: const Text(
                      'All',
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white70),
                    onPressed: () {},
                    child: const Text(
                      'English for kids',
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white70),
                    onPressed: () {},
                    child: const Text(
                      'English for Business',
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white70),
                    onPressed: () {},
                    child: const Text(
                      'Conversational',
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white70),
                    onPressed: () {},
                    child: const Text(
                      'STARTERS',
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white70),
                    onPressed: () {},
                    child: const Text(
                      'MOVERS',
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white70),
                    onPressed: () {},
                    child: const Text(
                      'FLYERS',
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white70),
                    onPressed: () {},
                    child: const Text(
                      'KET',
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white70),
                    onPressed: () {},
                    child: const Text(
                      'PET',
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white70),
                    onPressed: () {},
                    child: const Text(
                      'IELTS',
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white70),
                    onPressed: () {},
                    child: const Text(
                      'TOELF',
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white70),
                    onPressed: () {},
                    child: const Text(
                      'TOEIC',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            )
          ],
        ));
  }
}
