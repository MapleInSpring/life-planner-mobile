import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:life_planner/app_widgets/action_list/fetch_action_list.dart';
import 'package:life_planner/common_widgets/category_list_widget.dart';
import 'package:life_planner/models/idea_list.dart';

class ActionListWidget extends StatelessWidget {
  final Future<IdeaList> actionList = fetchActionList();
  final CollectionReference currentItems = Firestore.instance.collection(
      'currentItem');

  sendAction(Idea idea) {
    currentItems.document().setData(idea.toJson());
  }

  List<ListItem> getListItems(List<Idea> ideas) {
    var ideasByCategory = groupBy(
        ideas, (Idea idea) => idea.category);
    var categories = ideasByCategory.keys;
    List<ListItem> listItems = [];

    for (var category in categories) {
      listItems.add(HeadingItem(category));
      listItems.addAll(
          ideasByCategory[category].map((Idea idea) =>
              BasicItem(title: idea.title, idea: idea, ))
      );
    }

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<IdeaList>(
      future: actionList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          return CategoryListWidget(ideaList: snapshot.data.ideas, onTap: this.sendAction);

        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
  }
}
