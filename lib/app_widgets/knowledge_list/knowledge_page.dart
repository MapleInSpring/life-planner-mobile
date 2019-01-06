import 'package:flutter/material.dart';
import 'package:life_planner/app_widgets/knowledge_list/knowledge_list_widget.dart';

class KnowledgePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            KnowledgeListWidget()
          ],
        )
    );
  }

}
