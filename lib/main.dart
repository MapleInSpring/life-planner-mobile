import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:life_planner/fetch_idea_list.dart';

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
        ),
      ),
    );
  }
}

class IdeaList extends StatelessWidget {
  final Future<IdeaListResponse> ideaList;

  const IdeaList({Key key, this.ideaList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<IdeaListResponse>(
      future: ideaList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data.ideas.map((i) => Text(i.title)).toList(),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner
        return CircularProgressIndicator();
      },
    );
  }
}