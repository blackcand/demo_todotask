import 'dart:convert';

enum Filter { Home, Work, Personal }

Map<String, dynamic> data = {
  "data": [
    {
      "date": DateTime.now(),
      "tasks": [
        {
          "id": int,
          "tittle": String,
          "desciption": String,
          "isComplete": false,
          "type": Filter
        }
      ]
    }
  ]
};

List<Tasks> tasksFromJson(String str) =>
    List<Tasks>.from(json.decode(str).map((x) => Tasks.fromJson(x)));

String tasksToJson(List<Tasks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tasks {
  Tasks({
    this.date,
    this.tasks,
  });

  String date;
  List<Task> tasks;

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        date: json["date"],
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
      };
}

class Task {
  Task({
    this.id,
    this.tittle,
    this.desciption,
    this.isComplete,
    this.type,
  });

  int id;
  String tittle;
  String desciption;
  bool isComplete;
  String type;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        tittle: json["tittle"],
        desciption: json["desciption"],
        isComplete: json["isComplete"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tittle": tittle,
        "desciption": desciption,
        "isComplete": isComplete,
        "type": type,
      };
}
