import 'package:flutter/material.dart';

class NoteDetails extends StatelessWidget {
  const NoteDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20, color: Colors.white);
    return Card(
      color: Colors.orange,
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'Name: abcvdasf',
                  style: textStyle,
                ),
                Text(
                  'Priority: dsfaj',
                  style: textStyle,
                ),
                Text(
                  'Status: dsafdf',
                  style: textStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Plan Date: 2142',
                  style: textStyle,
                ),
                Text(
                  'Create Date: 12313',
                  style: textStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
