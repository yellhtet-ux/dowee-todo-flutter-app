// ignore_for_file: sized_box_for_whitespace

import 'package:dowee_app/model/task.dart';
import 'package:dowee_app/utils/components/custom_button.dart';
import 'package:flutter/material.dart';

class NewTaskDialogBox extends StatelessWidget {
  final String? taskStatus;
  final TextEditingController? newTaskTFController;
  final VoidCallback addNewTaskOnPressed;
  final VoidCallback cancelPressed;
  final ValueChanged<String?>? statusChangePressed;
  const NewTaskDialogBox({
    super.key,
    required this.taskStatus,
    required this.addNewTaskOnPressed,
    required this.cancelPressed,
    required this.statusChangePressed,
    required this.newTaskTFController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 230,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            spacing: 20.0,
            children: [
              //! New Task Text Field
              TextField(
                controller: newTaskTFController,
                decoration: InputDecoration(
                  hintText: "Just add a new Task..",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),

              //! Status Dropdown
              Container(
                padding: EdgeInsets.only(left: 5,right: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: BoxBorder.all(color: Colors.black),
                ),
                child: DropdownButton(
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
                  onChanged: statusChangePressed,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  underline: SizedBox(),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5.0,
                //! Add Task Btn
                children: [
                  CustomButton(
                    btnName: "Add Task",
                    btnAction: addNewTaskOnPressed,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),

                  //! Cancel Btn
                  CustomButton(
                    btnName: "Cancel",
                    btnAction: cancelPressed,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
