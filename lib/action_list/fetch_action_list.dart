import 'dart:convert';

import 'package:http/http.dart' as http;

Future<ActionListResponse> fetchActionList() async {
  final response =
  await http.get('https://life-planner-api-dev.cfapps.io/actions');

  if (response.statusCode == 200) {
    return ActionListResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class ActionListResponse {
  final List<ActionResponse> actions;

  ActionListResponse({this.actions});

  factory ActionListResponse.fromJson(List<dynamic> list) {
    List<ActionResponse> actionList =
        list.map((i) => ActionResponse.fromJson(i)).toList();

    return ActionListResponse(actions: actionList);
  }
}

class ActionResponse {
  final int id;
  final String title;
  final int parent;

  ActionResponse({this.id, this.title, this.parent});

  factory ActionResponse.fromJson(Map<String, dynamic> json) {
    return ActionResponse(
        id: json['id'], title: json['title'], parent: json['parent']);
  }
}
