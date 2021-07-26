import 'package:tasks/Model/task_model.dart';

abstract class TaskEvent {}

class UpdateTask extends TaskEvent {
  UpdateTask(this.task);

  final Tasks task;
}

class AddTask extends TaskEvent {
  AddTask(this.task);

  final Tasks task;
}

class GetTasks extends TaskEvent {}
