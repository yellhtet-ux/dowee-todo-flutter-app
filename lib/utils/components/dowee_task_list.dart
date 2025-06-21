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
                  child: Text(TaskStatus.inProgress),
                  value: TaskStatus.inProgress,
                ),
                DropdownMenuItem(
                  child: Text(TaskStatus.completed),
                  value: TaskStatus.completed,
                ),
                DropdownMenuItem(
                  child: Text(TaskStatus.onHold),
                  value: TaskStatus.onHold,
                ),
                DropdownMenuItem(
                  child: Text(TaskStatus.cancelled),
                  value: TaskStatus.cancelled,
                ),
                DropdownMenuItem(
                  child: Text(TaskStatus.toDo),
                  value: TaskStatus.toDo,
                ),
              ],
              value: taskStatus,
              onChanged: onStatusChanged,
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
              underline: SizedBox(),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: taskStatus == TaskStatus.inProgress
              ? Colors.yellow
              : taskStatus == TaskStatus.completed
              ? Colors.green
              : taskStatus == TaskStatus.onHold
              ? Colors.orange
              : taskStatus == TaskStatus.toDo 
              ? Colors.grey : Colors.red,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
