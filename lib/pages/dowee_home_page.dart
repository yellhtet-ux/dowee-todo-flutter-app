import 'package:dowee_app/model/task_model.dart';
import 'package:dowee_app/utils/components/dowee_task_list.dart';
import 'package:flutter/material.dart';

class DoweeHomePage extends StatefulWidget {
  const DoweeHomePage({super.key});

  @override
  State<DoweeHomePage> createState() => _DoweeHomePageState();
}

class _DoweeHomePageState extends State<DoweeHomePage> {
  //! This is a list of tasks that will be displayed in the app
  final Map<String, List<Task>> _taskList = {
    TaskSectionTitle.inProgress : [
      Task(taskName: "Buy Coffee", taskStatus: TaskStatus.inProgress),
      Task(taskName: "Do Some Exercises", taskStatus: TaskStatus.inProgress),
      Task(
        taskName: "Chill at bar with Geroge",
        taskStatus: TaskStatus.inProgress,
      ),
    ],

    TaskSectionTitle.completed: [
      Task(taskName: "Buy Groceries", taskStatus: TaskStatus.completed),
      Task(taskName: "Read a Book", taskStatus: TaskStatus.completed),
    ],

    TaskSectionTitle.onHold: [
      Task(taskName: "Buy a new Laptop", taskStatus: TaskStatus.onHold),
      Task(taskName: "Buy a new Phone", taskStatus: TaskStatus.onHold),
    ],

    TaskSectionTitle.cancelled: [
      Task(taskName: "Buy a new Car", taskStatus: TaskStatus.cancelled),
      Task(taskName: "Buy a new House", taskStatus: TaskStatus.cancelled),
    ],
  };

  void _onStatusChanged(
    TaskStatus? selectedStatus,
    int index,
    Task selectedTask,
    String categoryTitle,
  ) {
    setState(() {
      if (selectedStatus == null) return;

      _taskList[categoryTitle]!.removeAt(index);

      _taskList[categoryTitle]!.add(
        Task(taskName: selectedTask.taskName, taskStatus: selectedStatus),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _taskList.entries.map<Widget>((element) {
        final categoryTitle = element.key;
        final taskList = element.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(title: Text(categoryTitle)),
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
    );
  }
}
