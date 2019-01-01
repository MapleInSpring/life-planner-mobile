
import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentItem {
  final int id;
  final String title;
  final int parent;


  CurrentItem({this.id, this.title, this.parent});

  factory CurrentItem.fromSnapshot(DocumentSnapshot document) {

    return CurrentItem(
        id: document["id"],
        title: document["title"],
        parent: document["parent"]
    );
  }

  toJson() {
    return {
      "id": id,
      "title": title,
      "parent": parent
    };
  }
}
