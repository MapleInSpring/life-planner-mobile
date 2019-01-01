import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:life_planner/models/idea_list.dart';

Future<IdeaList> fetchActionList() async {
  final response =
  await http.get('https://life-planner-api-dev.cfapps.io/actions');

  if (response.statusCode == 200) {
    return IdeaList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

