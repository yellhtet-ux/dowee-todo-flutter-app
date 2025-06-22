import 'package:dowee_app/main.dart';
import 'package:dowee_app/model/task.dart';

const String toDoBoxKey = "TODOLIST";

class TaskDatabase {
  Map<String, List<Task>> toDoList = {};

  //! Load data
  void loadDBData() {
    final Map? rawData = dooWeeBox.get(toDoBoxKey);

    if (rawData is Map) {
      toDoList = rawData.map<String, List<Task>>((key, value) {
        return MapEntry(key as String, List<Task>.from(value));
      });
    }
  }

  //! Update the database
  void updateDBData(String status, Task newTask) {
    if (!toDoList.containsKey(status)) {
      toDoList[status] = [];
    }
    toDoList[status]!.add(newTask);
    dooWeeBox.put(toDoBoxKey, toDoList);
    loadDBData();
  }

  void updateTaskStatusChangedDBData(
    String? selectedStatus,
    int index,
    Task selectedTask,
    String categoryTitle,
  ) {
    if (selectedStatus == null) return;
    toDoList[categoryTitle]?.removeAt(index) ?? [];
    if (!toDoList.containsKey(selectedStatus)) {
      toDoList[selectedStatus] = [];
    }

    toDoList[selectedStatus]!.add(
      Task(taskName: selectedTask.taskName, taskStatus: selectedStatus),
    );
    dooWeeBox.put(toDoBoxKey, toDoList);
    loadDBData();
  }

  void deleteTask(int index,String? categoryTitle) {
    toDoList[categoryTitle]?.removeAt(index) ?? [];
    dooWeeBox.put(toDoBoxKey, toDoList);
    loadDBData();
  }
}

class TaskMock {
  // ignore: unused_field
  static final Map<String, List<Task>> _mockToDoList = {
    TaskStatus.toDo.name: [
      Task(taskName: "Holla", taskStatus: TaskStatus.toDo.name),
      Task(taskName: "Another Holla", taskStatus: TaskStatus.toDo.name),
    ],

    TaskStatus.inProgress.name: [
      Task(taskName: "Hello", taskStatus: TaskStatus.inProgress.name),
      Task(taskName: "Another Hello", taskStatus: TaskStatus.inProgress.name),
    ],

    TaskStatus.completed.name: [
      Task(taskName: "Mingalabar", taskStatus: TaskStatus.completed.name),
      Task(
        taskName: "Another Mingalabar",
        taskStatus: TaskStatus.completed.name,
      ),
      Task(
        taskName: "Another Mingalabar 2",
        taskStatus: TaskStatus.completed.name,
      ),
    ],

    TaskStatus.onHold.name: [
      Task(taskName: "Bonjour", taskStatus: TaskStatus.onHold.name),
      Task(taskName: "Another Bonjour", taskStatus: TaskStatus.inProgress.name),
      Task(taskName: "Another Bonjour 2", taskStatus: TaskStatus.onHold.name),
    ],
  };
}
