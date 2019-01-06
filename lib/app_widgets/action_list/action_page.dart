import 'package:flutter/material.dart';
import 'package:life_planner/app_widgets/action_list/action_list.dart';
import 'package:life_planner/app_widgets/action_list/action_list_widget.dart';


class ActionPage extends StatefulWidget {
  @override
  _ActionPageState createState() => _ActionPageState();
}


class _ActionPageState extends State<ActionPage> {

  bool _showToday = false;

  Function _actionFilter;

  _ActionPageState() {
    _actionFilter = this.getActions;
  }

  void _onSwitchChanged(bool value) {
    setState(() {
      _showToday = value;
      if (_showToday) {
        _actionFilter = this.getActiveActions;
      } else {
        _actionFilter = this.getActions;
      }
    });
  }

  List<Action> getActions(Iterable<Action> actionList) {
    return actionList.toList();
  }

  List<Action> getActiveActions(Iterable<Action> actionList) {
    return actionList
        .where((action) => action.status == 'ACTIVE')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ShowTodaySwitchWidget(show: _showToday, onChange: _onSwitchChanged,),
          ActionListWidget(actionFilter: _actionFilter,)
        ],
      ),
    );
  }

}

class ShowTodaySwitchWidget extends StatelessWidget {
  final bool show;
  final Function onChange;

  const ShowTodaySwitchWidget({Key key, this.show, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: new Text("Show Today's actions"),
      secondary: const Icon(Icons.alarm),
      value: show,
      onChanged: (bool value) {
        onChange(value);
      },
    );
  }

}
