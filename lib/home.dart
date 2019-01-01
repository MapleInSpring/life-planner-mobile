import 'package:flutter/material.dart';
import 'package:life_planner/action_list/action_list.dart';
import 'package:life_planner/action_list/fetch_action_list.dart';
import 'package:life_planner/current_list/current_list.dart';

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
            icon: Icon(Icons.assignment),
            title: Text('Current'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            title: Text('All'),
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
