enum TaskStatus { inProgress, completed, onHold, cancelled }

class TaskSectionTitle {
  static final inProgress = "In Progress";
  static final completed = "Completed";
  static final onHold = "On Hold";
  static final cancelled = "Cancelled";
}

class Task {
  String taskName;
  TaskStatus taskStatus;

  Task({required this.taskName, required this.taskStatus});
}
