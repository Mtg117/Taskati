import 'dart:io';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/core/widgets/header.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/widgets/task_item.dart';
import 'package:taskati/features/add_task/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  final String? errorMessage;
  const HomeScreen({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text(errorMessage!,style: getTitleTextStyle(fontSize: 17,color:AppColor.whiteColor ),)),
            backgroundColor: Colors.red,
          ),
        );
      });
    }

    var userBox = Hive.box("user");
    String name = userBox.get("name");
    String path = userBox.get("image");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              header(
                title: "Hello , ${name}",
                customWidget: CircleAvatar(
                  radius: 70,
                  backgroundImage: FileImage(File(path)),
                ),
              ),
              SizedBox(height: 20),
              header(
                title: DateFormat.yMMMd().format(DateTime.now()),
                customWidget: customButton(
                  text: "+ Add Task",
                  width: 140,
                  onPressed: () {
                    pushTo(context, AddTaskScreen());
                  },
                ),
              ),
              SizedBox(height: 20),
              DatePicker(
                height: 100,
                width: 80,
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColor.blueVioletColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                },
              ),
              SizedBox(height: 20),
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: Hive.box('task').listenable(),
                builder: (context, Box taskBox, child) {
                  var tasks = taskBox.values.toList();
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                          } else {
                            taskBox.deleteAt(index);
                          }
                        },
                        background: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.greenColor,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 4),
                                  blurRadius: 0,
                                  color: Colors.black26,
                                ),
                              ]),
                          child: Row(
                            children: [
                              Icon(
                                Icons.turned_in,
                                color: AppColor.whiteColor,
                              ),
                              Text(
                                "Complete",
                                style: getSmallTextStyle(
                                    color: AppColor.whiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        secondaryBackground: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 4),
                                  blurRadius: 0,
                                  color: Colors.black26,
                                ),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.delete,
                                color: AppColor.whiteColor,
                              ),
                              Text(
                                "Delete",
                                style: getSmallTextStyle(
                                    color: AppColor.whiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        key: UniqueKey(),
                        child: task_item(
                          task: tasks[index],
                        ),
                      );
                    },
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
