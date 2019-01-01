import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_planner/current_list/current_item.dart';

class CurrentItemListWidget extends StatelessWidget {

  final CollectionReference currentItems = Firestore.instance.collection('currentItem');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: currentItems.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');

        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return CircularProgressIndicator();
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                var currentItem = CurrentItem.fromSnapshot(document);

                return new ListTile(
                  title: new Text(currentItem.title),
                  subtitle: new Text(currentItem.id.toString()),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
