import 'package:hive/hive.dart';

part 'task.g.dart';

class TaskStatus {
  static final inProgress = "In Progress";
  static final completed = "Completed";
  static final onHold = "On Hold";
  static final cancelled = "Cancelled";
  static final toDo = "To Do";
}

// class Task {
//   String taskName;
//   String taskStatus;

//   Task({required this.taskName, required this.taskStatus});
// }

@HiveType(typeId: 1,adapterName: "TaskAdapter")
class Task {
  Task({required this.taskName, required this.taskStatus});

  @HiveField(0)
  String taskName;

  @HiveField(1)
  String taskStatus;
}
