import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/features/home/home_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var dateController = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  var startTimeController = TextEditingController(
      text: DateFormat("hh :mm a").format(DateTime.now()));
  var endTimeController = TextEditingController(
      text: DateFormat("hh :mm a").format(DateTime.now()));
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: getTitleTextStyle(
            color: AppColor.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: getTitleTextStyle(fontSize: 22),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value != null) {
                    if (value.length < 5) {
                      return "Title should have at least 5 characters";
                    }
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              Text(
                "Note",
                style: getTitleTextStyle(fontSize: 22),
              ),
              SizedBox(height: 5),
              TextFormField(
                maxLines: 4,
                controller: noteController,
                validator: (value) {
                  if (value != null) {
                    if (value.length < 10) {
                      return "Title should have at least 10 characters";
                    }
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              Text(
                "Date",
                style: getTitleTextStyle(fontSize: 22),
              ),
              SizedBox(height: 5),
              TextFormField(
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    lastDate: DateTime(2027),
                  ).then(
                    (value) {
                      if (value != null) {
                        dateController.text =
                            DateFormat("dd/MM/yyyy").format(value);
                      }
                    },
                  );
                },
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                  Icons.calendar_month,
                  color: AppColor.blueVioletColor,
                )),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Time",
                          style: getTitleTextStyle(fontSize: 18),
                        ),
                        TextFormField(
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then(
                              (value) {
                                if (value != null) {
                                  startTimeController.text =
                                      value.format(context);
                                }
                              },
                            );
                          },
                          controller: startTimeController,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.access_time),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "End Time",
                          style: getTitleTextStyle(fontSize: 18),
                        ),
                        TextFormField(
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then(
                              (value) {
                                if (value != null) {
                                  endTimeController.text =
                                      value.format(context);
                                }
                              },
                            );
                          },
                          controller: endTimeController,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.access_time),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Row(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = index;
                            });
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: index == 0
                                ? AppColor.blueVioletColor
                                : index == 1
                                    ? AppColor.orangeColor
                                    : AppColor.primaryColor,
                            child: selectedColor == index
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                  Spacer(),
                  customButton(
                    text: "Create Task",
                    width: 150,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final start = TimeOfDay(
                          hour: int.parse(
                              startTimeController.text.split(":")[0].trim()),
                          minute: int.parse(startTimeController.text
                              .split(":")[1]
                              .split(" ")[0]
                              .trim()),
                        );

                        final end = TimeOfDay(
                          hour: int.parse(
                              endTimeController.text.split(":")[0].trim()),
                          minute: int.parse(endTimeController.text
                              .split(":")[1]
                              .split(" ")[0]
                              .trim()),
                        );
                        if (start.hour > end.hour ||
                            (start.hour == end.hour &&
                                start.minute >= end.minute)) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                errorMessage:
                                    "The start time must be before the end time",
                              ),
                            ),
                          );
                        } else {
                          TaskModel newTask = TaskModel(
                              id: DateTime.now().toString() +
                                  titleController.text,
                              title: titleController.text,
                              note: noteController.text,
                              date: dateController.text,
                              startTime: startTimeController.text,
                              endTime: endTimeController.text,
                              color: selectedColor,
                              isCompleted: false);
                          var taskBox = Hive.box("task");
                          taskBox.put(newTask.id, newTask);
                          pushWithReplacement(context, HomeScreen());
                        }
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
