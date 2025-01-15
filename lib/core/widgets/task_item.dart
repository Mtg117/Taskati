import 'package:flutter/material.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';

class task_item extends StatelessWidget {
  final TaskModel task;
  const task_item({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: task.color == 0
              ? AppColor.blueVioletColor
              : task.color == 1
                  ? AppColor.orangeColor
                  : AppColor.primaryColor),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getTitleTextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  task.note,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getTitleTextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppColor.whiteColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${task.startTime} - ${task.endTime}",
                      style: getTitleTextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: AppColor.whiteColor,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              "TODO",
              style:
                  getTitleTextStyle(color: AppColor.whiteColor, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
