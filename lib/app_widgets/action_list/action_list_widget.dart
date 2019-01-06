import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:life_planner/app_widgets/action_list/action_list.dart';
import 'package:life_planner/app_widgets/action_list/action_list_helper.dart';
import 'package:life_planner/common_widgets/category_list_widget.dart';
import 'package:life_planner/models/idea_list.dart';

class ActionListWidget extends StatelessWidget {

  final CollectionReference allActions = Firestore.instance.collection(
      'allActions');

  final bool showTodayActions;

  ActionListWidget({Key key, this.showTodayActions}) : super(key: key);

  updateStatus(Idea idea) {
    print('will update status later');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: allActions.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var actionList = snapshot.data.documents
              .map((DocumentSnapshot document) => Action.fromSnapshot(document))
              .toList();
          var helper = ActionListHelper(showTodayActions: showTodayActions, actionList: actionList);
          helper.actionList = actionList;

          return CategoryListWidget(
              items: helper.getFilteredListItem(), onTap: this.updateStatus);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
  }
}
