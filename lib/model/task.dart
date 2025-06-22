import 'package:hive/hive.dart';

part 'task.g.dart';

enum TaskStatus {
  toDo,
  inProgress,
  onHold,
  completed,
  cancelled;

  String get name {
    switch (this) {
      case TaskStatus.toDo:
        return 'To Do';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.cancelled:
        return "Cancelled";
      case TaskStatus.completed:
        return "Completed";
      case TaskStatus.onHold:
        return "On Hold";
    }
  }
}

@HiveType(typeId: 1, adapterName: "TaskAdapter")
class Task {
  Task({required this.taskName, required this.taskStatus});

  @HiveField(0)
  String taskName;

  @HiveField(1)
  String taskStatus;
}
