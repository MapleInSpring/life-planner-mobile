import 'package:flutter/material.dart';
import 'package:life_planner/app_widgets/action_list/action_list.dart';
import 'package:life_planner/app_widgets/current_list/current_list.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    CurrentItemListWidget(),
    ActionListWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan your life!'),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('行'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.description),
            title: Text('知'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
