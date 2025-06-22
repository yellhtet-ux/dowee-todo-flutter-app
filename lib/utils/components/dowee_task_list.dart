import 'package:dowee_app/model/task.dart';
import 'package:flutter/material.dart';

class DoweeTaskList extends StatelessWidget {
  final String? taskTitle;
  final String? taskStatus;
  final ValueChanged<String?>? onStatusChanged;

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
            //* Task Title */
            Text(taskTitle ?? "No Title"),

            //* Spacer */
            const Spacer(),

            //* Task Status Dropdown */
            DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Text(TaskStatus.inProgress.name),
                  value: TaskStatus.inProgress.name,
                ),
                DropdownMenuItem(
                  child: Text(TaskStatus.completed.name),
                  value: TaskStatus.completed.name,
                ),
                DropdownMenuItem(
                  child: Text(TaskStatus.onHold.name),
                  value: TaskStatus.onHold.name,
                ),
                DropdownMenuItem(
                  child: Text(TaskStatus.cancelled.name),
                  value: TaskStatus.cancelled.name,
                ),
                DropdownMenuItem(
                  child: Text(TaskStatus.toDo.name),
                  value: TaskStatus.toDo.name,
                ),
              ],
              value: taskStatus,
              onChanged: onStatusChanged,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              underline: SizedBox(),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: taskStatus == TaskStatus.inProgress.name
              ? Colors.yellow
              : taskStatus == TaskStatus.completed.name
              ? Colors.green
              : taskStatus == TaskStatus.onHold.name
              ? Colors.orange
              : taskStatus == TaskStatus.toDo.name
              ? Colors.grey
              : Colors.red,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
