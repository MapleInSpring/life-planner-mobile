import 'package:flutter/material.dart';
import 'package:life_planner/action_list/fetch_action_list.dart';

class ActionListWidget extends StatelessWidget {

  const ActionList({Key key, this.actionList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ActionList>(
      future: actionList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data.actions
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
