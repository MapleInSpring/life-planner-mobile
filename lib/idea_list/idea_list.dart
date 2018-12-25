import 'package:flutter/material.dart';
import 'package:life_planner/idea_list/fetch_idea_list.dart';

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
            children: snapshot.data.ideas
                .map((i) => ListTile(title: Text(i.title)))
                .toList(),
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
