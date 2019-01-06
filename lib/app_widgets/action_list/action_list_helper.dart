import 'package:collection/collection.dart';
import 'package:life_planner/app_widgets/action_list/action_list.dart';
import 'package:life_planner/common_widgets/category_list_widget.dart';

class ActionListHelper {
  bool showTodayActions = false;
  List<Action> actionList = [];


  ActionListHelper({this.showTodayActions, this.actionList});

  List<ListItem> getFilteredListItem() {
    var actions = this._filterActions();
    return this._getListItems(actions);
  }

  List<ListItem> _getListItems(List<Action> actions) {
    var actionsByGoal = groupBy(actions, (Action action) => action.goal);
    var categories = actionsByGoal.keys;
    List<ListItem> items = [];

    for (var category in categories) {
      items.add(HeadingItem(category));
      items.addAll(actionsByGoal[category].map((Action action) =>
          BasicItem(title: action.title)));
    }

    return items;
  }

  List<Action> _filterActions() {
    if (showTodayActions) {
      return actionList.where((action) => action.status == ActionStatus.ACTIVE).toList();
    }

    return actionList;
  }
}
