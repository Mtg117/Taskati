import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/features/home/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate() && path != null) {
                  var userBox = Hive.box("user");
                  userBox.put("name", nameController.text);
                  userBox.put("image", path);
                  userBox.put('isUploaded', true);
                  pushWithReplacement(context, HomeScreen());
                } else if (path == null) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Error !",
                          style:
                              getSmallTextStyle(color: AppColor.primaryColor),
                        ),
                        content: Text(
                          "Plz upload image",
                          style: getTitleTextStyle(
                            color: AppColor.blackColor,
                            fontSize: 20,
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "OK",
                                style: getSmallTextStyle(
                                    color: AppColor.primaryColor),
                              ))
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                "Done",
                style: getSmallTextStyle(),
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: path != null
                    ? FileImage(File(path!))
                    : NetworkImage('https://picsum.photos/200'),
              ),
              SizedBox(height: 30),
              customButton(
                text: "Upload From Camera",
                onPressed: () async {
                  await ImagePicker()
                      .pickImage(source: ImageSource.camera)
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        path = value.path;
                      });
                    }
                  });
                },
              ),
              SizedBox(height: 10),
              customButton(
                text: "Upload From Gallery",
                onPressed: () async {
                  await ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        path = value.path;
                      });
                    }
                  });
                },
              ),
              SizedBox(height: 10),
              Divider(
                color: AppColor.blueVioletColor,
                indent: 20,
                endIndent: 20,
                thickness: 2,
              ),
              SizedBox(height: 10),
              Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name is required";
                    } else if (value.length < 3) {
                      return "Name should be at least 3 characters";
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Name ...",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.blueVioletColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.blueVioletColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
