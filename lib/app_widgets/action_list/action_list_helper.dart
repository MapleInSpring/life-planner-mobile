import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:life_planner/app_widgets/action_list/action_list.dart';
import 'package:life_planner/common_widgets/category_list_widget.dart';

class ActionListHelper {
  bool showTodayActions = false;
  List<Action> actionList = [];


  ActionListHelper({this.showTodayActions, this.actionList});

  List<ListItem> getListItem() {
    if (showTodayActions) {
      var actionList = this._getActiveActions();
      return this._getDetailedListItem(actionList);
    }

    return this._getListItems(actionList);
  }

  List<ListItem> _getDetailedListItem(List<Action> actionList) {
    var actionsByGoal = groupBy(actionList, (Action action) => action.goal);
    var categories = actionsByGoal.keys;
    List<ListItem> items = [];

    for (var category in categories) {
      items.add(HeadingItem(category));
      var detailedItems = actionsByGoal[category]
          .map((Action action) => DetailedItem(
          title: action.title,
          children: action.subtasks.map((task) => Text(task.description)).toList()));

      items.addAll(detailedItems);
    }

    return items;
  }

  List<ListItem> _getListItems(List<Action> actionList) {
    var actionsByGoal = groupBy(actionList, (Action action) => action.goal);
    var categories = actionsByGoal.keys;
    List<ListItem> items = [];

    for (var category in categories) {
      items.add(HeadingItem(category));
      items.addAll(actionsByGoal[category]
          .map((Action action) => BasicItem(title: action.title)));
    }

    return items;
  }

  List<Action> _getActiveActions() {
      return actionList.where((action) => action.status == ActionStatus.ACTIVE)
          .toList();
  }
}
