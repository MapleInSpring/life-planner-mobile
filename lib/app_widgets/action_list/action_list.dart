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
  final ActionStatus status;

  Action({
    this.id,
    this.title,
    this.goal,
    this.frequency,
    this.enddate,
    this.subtasks,
    this.timebox,
    this.status
  });

  factory Action.fromSnapshot(DocumentSnapshot document) {
    var subtasksDocument = document["subtasks"] as List;
    List<ActionTask> subtasks = subtasksDocument?.map((task) =>
        ActionTask.fromSnapshot(task));

    var actionStatus = ActionStatus.UNSET;
    if (document["status"] != null) {
      actionStatus = ActionStatus.values.firstWhere((s) => s.toString() == document["status"]);
    }

    return Action(
        id: document["id"],
        title: document["title"],
        goal: document["goal"],
        frequency: document["frequency"],
        enddate: document["enddate"],
        subtasks: subtasks,
        timebox: document["timebox"],
        status: actionStatus
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

enum ActionStatus { ACTIVE, FINISHED, ONHOLD, UNSET }
