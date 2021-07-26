import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tasks/Blocs/TaskBloc/task_event.dart';
import 'package:tasks/Blocs/TaskBloc/task_state.dart';
import 'package:tasks/Model/task_model.dart';

class TaskBloc {
  static TaskBloc taskBloc = new TaskBloc();
  var state = TasksState([]);

  final eventController = StreamController<TaskEvent>();
  final stateController = StreamController<TasksState>();
  final stateProcessController = StreamController<TasksState>();

  Future<List<Tasks>> getTask() async {
    List<Tasks> tasks = [];
    final sharedPrefs = await SharedPreferences.getInstance();
    String tasksStr = sharedPrefs.getString("all_task");
    if (tasksStr != null) {
      tasks = tasksFromJson(tasksStr);
    }
    return tasks;
  }

  saveLocal(List<Tasks> list) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String taskStr = tasksToJson(list);
    sharedPrefs.setString("all_task", taskStr);
  }

  TaskBloc() {
    eventController.stream.listen((TaskEvent event) async {
      List<Tasks> tasks = await getTask();
      if (event is GetTasks) {
        print("==1: ${tasks.length}");
        state = TasksState(tasks);
      } else if (event is UpdateTask) {
        TasksState statetemp = state;
        int index =
            statetemp.tasks.indexWhere((item) => item.date == event.task.date);
        if (index != -1) {
          statetemp.tasks[index].tasks.forEach((item) {
            if (item.id == event.task.tasks[0].id) {
              item = event.task.tasks[0];
            }
          });
          state = TasksState(statetemp.tasks);
        }
      } else if (event is AddTask) {
        TasksState statetemp = state;
        if (statetemp.tasks.length == 0) {
          statetemp.tasks.add(event.task);
        } else {
          int index = statetemp.tasks
              .indexWhere((item) => item.date == event.task.date);
          if (index != -1) {
            statetemp.tasks[index].tasks.addAll(event.task.tasks);
          } else
            statetemp.tasks.add(event.task);
        }
        state = TasksState(statetemp.tasks);
      }

      taskBloc.stateController.sink.add(state);
      taskBloc.stateProcessController.sink.add(state);

      if (event is AddTask || event is UpdateTask) {
        saveLocal(state.tasks);
      }
    });
  }
  void dispose() {
    stateProcessController.close();
    stateController.close();
    eventController.close();
  }
}
