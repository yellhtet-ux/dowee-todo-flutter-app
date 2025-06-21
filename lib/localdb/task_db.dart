import 'package:dowee_app/model/task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dowee_app/main.dart';

class TaskDatabase {
  Map<String, List<Task>> toDoList = {};

  //! Load data
  void loadDBData() {
    // toDoList = dooWeeBox.get(key);
  }

  //! Update the database
  void updateDBData() {
    // dooWeeBox.put("TODOLIST", toDoList);
  }
}
