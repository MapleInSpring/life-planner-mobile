import 'package:cloud_firestore/cloud_firestore.dart';

class ActionList {
  final List<Action> actions;

  ActionList({this.actions});

  factory ActionList.fromSnapshot(DocumentSnapshot document) {
    var actionsDocument = document as List;
    var actions = actionsDocument.map((action) => Action.fromSnapshot(action));

    return ActionList(
        actions: actions
    );
  }
}

class Action {
  final int id;
  final String title;
  final String goal;
  final String frequency;
  final DateTime enddate;
  final List<ActionTask> subtasks;
  final String timebox;

  Action(
      {this.id, this.title, this.goal, this.frequency, this.enddate, this.subtasks, this.timebox});

  factory Action.fromSnapshot(DocumentSnapshot document) {
    var subtasksDocument = document["subtasks"] as List;
    List<ActionTask> subtasks = subtasksDocument?.map((task) =>
        ActionTask.fromSnapshot(task));

    return Action(
        id: document["id"],
        title: document["title"],
        goal: document["goal"],
        frequency: document["frequency"],
        enddate: document["enddate"],
        subtasks: subtasks,
        timebox: document["timebox"]
    );
  }

  toJson() {
    return {
      "title": title,
      "subtasks": subtasks?.map((task) => task.toJson())?.toList(),
      "enddate": enddate
    };
  }
}

class ActionTask {
  final String description;
  final DateTime date;

  ActionTask({this.description, this.date});

  factory ActionTask.fromSnapshot(DocumentSnapshot document) {
    return ActionTask(
        description: document["description"],
        date: document["date"]
    );
  }

  toJson() {
    return {
      "descrption": description,
      "date": date
    };
  }
}
