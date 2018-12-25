import 'package:flutter/material.dart';
import 'package:life_planner/idea_list/fetch_idea_list.dart';
import 'package:life_planner/idea_list/idea_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: IdeaList(ideaList: fetchIdeaList()),
        )
      ),
    );
  }
}