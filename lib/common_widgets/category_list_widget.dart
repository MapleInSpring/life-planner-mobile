import 'package:flutter/material.dart';
import 'package:life_planner/models/idea_list.dart';

class CategoryListWidget extends StatelessWidget {

  final List<ListItem> items;
  final Function(Idea idea) onTap;

  const CategoryListWidget({
    Key key,
    this.items,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          if (item is HeadingItem) {
            return HeadingItemWidget(item: item,);
          } else if (item is BasicItem) {
            return ListTile(
              title: Text(item.title),
              onTap: () => this.onTap(item.idea),
            );
          }
        },
      ),
    );
  }

}

class HeadingItemWidget extends StatelessWidget {
  final HeadingItem item;

  const HeadingItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

  BasicItem({this.title, this.idea});
}

