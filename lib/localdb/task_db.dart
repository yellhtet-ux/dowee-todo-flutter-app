import 'package:dowee_app/main.dart';
import 'package:dowee_app/model/task.dart';

const String toDoBoxKey = "TODOLIST";

class TaskDatabase {
  Map<String, List<Task>> toDoList = {};

  //! Load data
  void loadDBData() {
    final Map? rawData = dooWeeBox.get(toDoBoxKey);

    print("DEBUG:: RAW HIVE DATA: $rawData");

    if (rawData is Map) {
      toDoList = rawData.map<String, List<Task>>((key, value) {
        return MapEntry(key as String, List<Task>.from(value));
      });
    }

    print("DEBUG:: LOADED TO DO LIST: $toDoList");
  }

  //! Update the database
  void updateDBData(String status, Task newTask) {
    if (!toDoList.containsKey(status)) {
      toDoList[status] = [];
    }
    toDoList[status]!.add(newTask);
    dooWeeBox.put(toDoBoxKey, toDoList);
    print("DEBUG:: SAVED TO DO LIST $toDoList");
    loadDBData();
  }

  void updateTaskStatausChangedDBData(
    String? selectedStatus,
    int index,
    Task selectedTask,
    String categoryTitle,
  ) {
    if (selectedStatus == null) return;
    toDoList[categoryTitle]?.removeAt(index) ?? [];
    if (!toDoList.containsKey(selectedStatus)) {
      toDoList[selectedStatus]!.add(selectedTask);
    } else {
      toDoList[selectedStatus]?.add(
      Task(taskName: selectedTask.taskName, taskStatus: selectedStatus),
    );
    }
    dooWeeBox.put(toDoBoxKey, toDoList);
    loadDBData();
  }
}

class TaskMock {
  static final Map<String, List<Task>> _mockToDoList = {
    TaskStatus.toDo: [
      Task(taskName: "Holla", taskStatus: TaskStatus.toDo),
      Task(taskName: "Another Holla", taskStatus: TaskStatus.toDo),
    ],

    TaskStatus.inProgress: [
      Task(taskName: "Hello", taskStatus: TaskStatus.inProgress),
      Task(taskName: "Another Hello", taskStatus: TaskStatus.inProgress),
    ],

    TaskStatus.completed: [
      Task(taskName: "Mingalabar", taskStatus: TaskStatus.completed),
      Task(taskName: "Another Mingalabar", taskStatus: TaskStatus.completed),
      Task(taskName: "Another Mingalabar 2", taskStatus: TaskStatus.completed),
    ],

    TaskStatus.onHold: [
      Task(taskName: "Bonjour", taskStatus: TaskStatus.onHold),
      Task(taskName: "Another Bonjour", taskStatus: TaskStatus.inProgress),
      Task(taskName: "Another Bonjour 2", taskStatus: TaskStatus.onHold),
    ],
  };
}
