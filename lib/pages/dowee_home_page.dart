// ignore_for_file: unnecessary_this, invalid_use_of_protected_member

import 'package:dowee_app/localdb/task_db.dart';
import 'package:dowee_app/model/task.dart';
import 'package:dowee_app/utils/components/dowee_task_list.dart';
import 'package:dowee_app/utils/components/newtask_dialogbox.dart';
import 'package:flutter/material.dart';

class DoweeHomePage extends StatefulWidget {
  const DoweeHomePage({super.key});

  @override
  State<DoweeHomePage> createState() => _DoweeHomePageState();
}

class _DoweeHomePageState extends State<DoweeHomePage> {
  //! Initialze db
  TaskDatabase db = TaskDatabase();

  //! Selected Status State
  String? _selectedNewTaskStatus = TaskStatus.toDo.name;

  //! New Task Text Field Controlelr
  final _newTaskTFController = TextEditingController();

  @override
  void initState() {
    //! Load the data when app start
    db.loadDBData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Dowee Todo List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: db.toDoList.isEmpty
          ? Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    "Welcome from Dowee Todo List App.\n Have Fun xD",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          : ListView(
              children: db.toDoList.entries.map<Widget>((element) {
                final categoryTitle = element.key;
                final taskList = element.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    taskList.isNotEmpty
                        ? ListTile(
                            title: Container(
                              padding: EdgeInsets.all(10.5),
                              child: Text(
                                categoryTitle,
                                style: TextStyle(
                                  color: categoryTitle == TaskStatus.inProgress.name
                                      ? Colors.yellow
                                      : categoryTitle == TaskStatus.completed.name
                                      ? Colors.green
                                      : categoryTitle == TaskStatus.onHold.name
                                      ? Colors.orange
                                      : categoryTitle == TaskStatus.toDo.name
                                      ? Colors.grey
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(), //! To disappear if there is no task in the section
                    ListView.builder(
                      itemCount: taskList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => DoweeTaskList(
                        taskStatus: taskList[index].taskStatus,
                        taskTitle: taskList[index].taskName,
                        onStatusChanged: (status) {
                          _onStatusChanged(
                            status,
                            index,
                            taskList[index],
                            categoryTitle,
                          );
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTaskDialogHandler,
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}

//! State Management Loic are in Here...
extension _DoweeHomePageStateExt on _DoweeHomePageState {
  //! This function is called when the status of a task is changed
  //! It updates the task list by removing the task from its current category
  //! and adding it to the new category based on the selected status
  void _onStatusChanged(
    String? selectedStatus,
    int index,
    Task selectedTask,
    String categoryTitle,
  ) {
    setState(() {
      db.updateTaskStatausChangedDBData(
        selectedStatus,
        index,
        selectedTask,
        categoryTitle,
      );
    });
  }

  //! Create New Task Action
  void createNewTask(BuildContext context) {
    setState(() {
      db.updateDBData(
        _selectedNewTaskStatus ?? "",
        Task(
          taskName: _newTaskTFController.text,
          taskStatus: _selectedNewTaskStatus ?? "",
        ),
      );
    });

    Navigator.of(context).pop(); //? Dismiss the diague
  }

  //! New Task Status Change
  void newTaskStatusChanded(String? status) {
    setState(() {
      _selectedNewTaskStatus = status;
    });
  }

  //! To create new task
  void createNewTaskDialogHandler() {
    showDialog(
      context: context,
      builder: (context) {
        return NewTaskDialogBox(
          newTaskTFController: _newTaskTFController,
          addNewTaskOnPressed: () {
            createNewTask(context);
          },
          cancelPressed: () => Navigator.of(context).pop(),
          statusChangePressed: (value) {
            newTaskStatusChanded(value);
          },
          taskStatus: _selectedNewTaskStatus,
        );
      },
    );
  }
}
