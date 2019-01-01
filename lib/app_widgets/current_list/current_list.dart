import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_planner/common_widgets/category_list_widget.dart';
import 'package:life_planner/models/idea_list.dart';

class CurrentItemListWidget extends StatelessWidget {

  final CollectionReference currentItems = Firestore.instance.collection(
      'currentItem');

  updateStatus(Idea idea) {
    print('will update status later');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: currentItems.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var currentItems = snapshot.data.documents
              .map((DocumentSnapshot document) => Idea.fromSnapshot(document))
              .toList();

          return CategoryListWidget(
              ideaList: currentItems, onTap: this.updateStatus);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        
        return CircularProgressIndicator();
      },
    );
  }
}
