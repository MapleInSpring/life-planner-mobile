import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:life_planner/app_widgets/knowledge_list/fetch_knowledge_list.dart';
import 'package:life_planner/common_widgets/category_list_widget.dart';
import 'package:life_planner/models/idea_list.dart';

class KnowledgeListWidget extends StatelessWidget {
  final Future<IdeaList> actionList = fetchKnowledgeList();
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
          var items = getListItems(snapshot.data.ideas);

          return CategoryListWidget(
              items: items,
              onTap: this.sendAction);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
  }
}
