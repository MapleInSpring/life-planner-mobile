import 'package:flutter/material.dart';
import 'package:life_planner/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plan your life!',
      home: Home(),
    );
  }
}