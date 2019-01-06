import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:life_planner/app_widgets/action_list/action_list.dart';
import 'package:life_planner/common_widgets/category_list_widget.dart';
import 'package:life_planner/models/idea_list.dart';

class ActionListWidget extends StatelessWidget {

  final CollectionReference allActions = Firestore.instance.collection(
      'allActions');

  final Function actionFilter;

  ActionListWidget({Key key, this.actionFilter}) : super(key: key);

  updateStatus(Idea idea) {
    print('will update status later');
  }

  List<ListItem> getListItems(List<Action> actions) {
    var actionsByGoal = groupBy(actions, (Action action) => action.goal);
    var categories = actionsByGoal.keys;
    List<ListItem> items = [];

    for (var category in categories) {
      items.add(HeadingItem(category));
      items.addAll(actionsByGoal[category].map((Action action) =>
          BasicItem(title: action.title)));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: allActions.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var actions = actionFilter(
              snapshot.data.documents.map((DocumentSnapshot document) =>
                  Action.fromSnapshot(document)));
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
