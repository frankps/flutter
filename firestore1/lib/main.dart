import 'package:flutter/material.dart';
import 'package:firebase1/ui/listview_note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: ListViewNote(),
    );

  }
}
