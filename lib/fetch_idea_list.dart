import 'dart:convert';

import 'package:http/http.dart' as http;

Future<IdeaListResponse> fetchIdeaList() async {
  final response =
  await http.get('https://life-planner-api-dev.cfapps.io/ideas');

  if (response.statusCode == 200) {
    return IdeaListResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class IdeaListResponse {
  final int mapId;
  final List<IdeaResponse> ideas;

  IdeaListResponse({this.mapId, this.ideas});

  factory IdeaListResponse.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);

    var list = parsedJson['ideas'] as List;
    List<IdeaResponse> ideaList =
        list.map((i) => IdeaResponse.fromJson(i)).toList();

    return IdeaListResponse(mapId: parsedJson['mapId'], ideas: ideaList);
  }
}

class IdeaResponse {
  final int id;
  final String title;
  final int parent;

  IdeaResponse({this.id, this.title, this.parent});

  factory IdeaResponse.fromJson(Map<String, dynamic> json) {
    return IdeaResponse(
        id: json['id'], title: json['title'], parent: json['parent']);
  }
}
