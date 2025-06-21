import 'package:dowee_app/localdb/task_db.dart';
import 'package:dowee_app/model/task.dart';
import 'package:dowee_app/utils/components/dowee_task_list.dart';
import 'package:flutter/material.dart';

class DoweeHomePage extends StatefulWidget {
  const DoweeHomePage({super.key});

  @override
  State<DoweeHomePage> createState() => _DoweeHomePageState();
}

class _DoweeHomePageState extends State<DoweeHomePage> {
  //! Initialze db
  TaskDatabase db = TaskDatabase();

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
      if (selectedStatus == null) return;
      db.toDoList[categoryTitle]?.removeAt(index) ?? [];
      db.toDoList[selectedStatus]?.add(
        Task(taskName: selectedTask.taskName, taskStatus: selectedStatus),
      );
    });

    db.updateDBData();
  }

  //! To create new task
  void createNewTaskHandler() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog();
      },
    );
  }

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
        title: Text("Dowee Todo List"),
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: db.toDoList.isEmpty
          ? Center(
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  "Welcome from Dowee Todo List App.\n Have Fun xD",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                                  color: categoryTitle == TaskStatus.inProgress
                                      ? Colors.yellow
                                      : categoryTitle == TaskStatus.completed
                                      ? Colors.green
                                      : categoryTitle == TaskStatus.onHold
                                      ? Colors.orange
                                      : categoryTitle == TaskStatus.toDo
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
        onPressed: createNewTaskHandler,
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
