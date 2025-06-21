import 'package:dowee_app/model/task_model.dart';
import 'package:flutter/material.dart';

class DoweeTaskList extends StatelessWidget {
  final String? taskTitle;
  final TaskStatus? taskStatus;
  final ValueChanged<TaskStatus?>? onStatusChanged;

  const DoweeTaskList({
    super.key,
    required this.taskStatus,
    required this.taskTitle,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        height: 50.0,
        width: double.infinity,
        child: Row(
          spacing: 15.0,
          children: [
            Text(taskTitle ?? "No Title"),

            const Spacer(),

            DropdownButton(
              items: const [
                DropdownMenuItem(
                  child: Text("In Progress"),
                  value: TaskStatus.inProgress,
                ),
                DropdownMenuItem(
                  child: Text("Completed"),
                  value: TaskStatus.completed,
                ),
                DropdownMenuItem(
                  child: Text("On Hold"),
                  value: TaskStatus.onHold,
                ),
                DropdownMenuItem(
                  child: Text("Cancelled"),
                  value: TaskStatus.cancelled,
                ),
              ],
              value: taskStatus,
              onChanged: onStatusChanged,
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
