import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_planner/action_list/fetch_action_list.dart';

class ActionListWidget extends StatelessWidget {
  final Future<ActionList> actionList = fetchActionList();
  final CollectionReference currentItems = Firestore.instance.collection(
      'currentItem');

  sendData(Action action) {
    print('sending data');

    currentItems.document().setData({
      'id': action.id,
      'title': action.title,
      'parent': action.parent
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ActionList>(
      future: actionList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data.actions
                .map((i) =>
                ListTile(
                  title: Text(i.title),
                  onTap: () => sendData(i),
                ))
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
