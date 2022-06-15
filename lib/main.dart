import 'package:flutter/material.dart';
import 'package:lytt/ui/total_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the front page
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lytt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LyttApp(title: "Test"),
    );
  }
}
