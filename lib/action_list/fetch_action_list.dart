import 'dart:convert';

import 'package:http/http.dart' as http;

Future<ActionList> fetchActionList() async {
  final response =
  await http.get('https://life-planner-api-dev.cfapps.io/actions');

  if (response.statusCode == 200) {
    return ActionList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class ActionList {
  final List<Action> actions;

  ActionList({this.actions});

  factory ActionList.fromJson(List<dynamic> list) {
    List<Action> actionList =
        list.map((i) => Action.fromJson(i)).toList();

    return ActionList(actions: actionList);
  }
}

class Action {
  final int id;
  final String title;
  final int parent;

  Action({this.id, this.title, this.parent});

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
        id: json['id'],
        title: json['title'],
        parent: json['parent']
    );
  }
}
