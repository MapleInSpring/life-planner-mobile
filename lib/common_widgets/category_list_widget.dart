import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:life_planner/models/idea_list.dart';

class CategoryListWidget extends StatelessWidget {

  final List<Idea> ideaList;
  final Function(Idea idea) onTap;

  const CategoryListWidget({
    Key key,
    this.ideaList,
    this.onTap
  }) : super(key: key);

  List<ListItem> getListItems(List<Idea> ideas) {
    var ideasByCategory = groupBy(
        ideas, (Idea idea) => idea.category);
    var categories = ideasByCategory.keys;
    List<ListItem> listItems = [];

    for (var category in categories) {
      listItems.add(HeadingItem(category));
      listItems.addAll(
          ideasByCategory[category].map((Idea idea) =>
              BasicItem(idea.title, idea))
      );
    }

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    var items = getListItems(this.ideaList);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        if (item is HeadingItem) {
          return Container(
            decoration: new BoxDecoration(
                color: Theme
                    .of(context)
                    .backgroundColor
            ),
            child: ListTile(
                title: Text(
                    item.heading,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline
                )
            ),
          );
        } else if (item is BasicItem) {
          return ListTile(
            title: Text(item.title),
            onTap: () => this.onTap(item.idea),
          );
        }
      },
    );
  }

}

abstract class ListItem {}

// A ListItem that contains data to display a heading
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

// A ListItem that contains data to display a message
class BasicItem implements ListItem {
  final String title;
  final Idea idea;

  BasicItem(this.title, this.idea);
}

