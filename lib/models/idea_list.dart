import 'package:cloud_firestore/cloud_firestore.dart';

class IdeaList {
  final List<Idea> ideas;

  IdeaList({this.ideas});

  factory IdeaList.fromJson(List<dynamic> list) {
    List<Idea> ideaList =
    list.map((i) => Idea.fromJson(i)).toList();

    return IdeaList(ideas: ideaList);
  }
}

class Idea {
  final int id;
  final String title;
  final int parent;
  final String category;

  Idea({this.id, this.title, this.parent, this.category});

  factory Idea.fromJson(Map<String, dynamic> json) {
    return Idea(
        id: json['id'],
        title: json['title'],
        parent: json['parent'],
        category: json['category']
    );
  }

  factory Idea.fromSnapshot(DocumentSnapshot document) {
    return Idea(
        id: document["id"],
        title: document["title"],
        parent: document["parent"],
        category: document["category"]
    );
  }

  toJson() {
    return {
      "id": id,
      "title": title,
      "parent": parent,
      "category": category
    };
  }
}
