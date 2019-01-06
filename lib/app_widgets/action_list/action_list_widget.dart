import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_planner/app_widgets/action_list/action_list.dart';
import 'package:life_planner/common_widgets/category_list_widget.dart';
import 'package:life_planner/models/idea_list.dart';

class ActionListWidget extends StatelessWidget {

  final CollectionReference currentItems = Firestore.instance.collection(
      'currentItem');

  final CollectionReference allActions = Firestore.instance.collection(
      'allActions');

  updateStatus(Idea idea) {
    print('will update status later');
  }

  List<ListItem> getListItems(List<Action> actions) {
    return actions
        .map((action) => BasicItem(title: action.title))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: allActions.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var actions = snapshot.data.documents
              .map((DocumentSnapshot document) => Action.fromSnapshot(document))
              .toList();
          var items = getListItems(actions);

          return CategoryListWidget(
              items: items, onTap: this.updateStatus);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
  }
}
