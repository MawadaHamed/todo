import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/app_theme.dart';
import 'package:untitled1/auth/user_provider.dart';
import 'package:untitled1/firebase_function.dart';
import 'package:untitled1/models/task_model.dart';
import 'package:untitled1/tabs/tasks/task_provider.dart';
import 'package:untitled1/widgets/default_elevated-button.dart';
import 'package:untitled1/widgets/default_text_form_field.dart';

class UpdateTask extends StatefulWidget {


 String oldTitle;
 String oldDescription;
 String taskId;

 UpdateTask({required this.oldTitle,required this.oldDescription,required this.taskId});


 @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  var formKey= GlobalKey<FormState>();
  TaskModel? task ;


  void initState() {
    super.initState();
    titleController.text = widget.oldTitle;
    descriptionController.text = widget.oldDescription;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? titlMediumStyle = Theme
        .of(context)
        .textTheme
        .titleMedium;
    return Scaffold(
       body:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery
                    .sizeOf(context)
                    .height * .5,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(15),
                        right: Radius.circular(15)
                    )
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('update Task',
                        style: titlMediumStyle,
                      ),
                      const SizedBox(height: 16,),
                      DefaultTextFormField(
                        controller: titleController,
                        hintText: 'Enter task title',
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return 'Title can not empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16,),
                      DefaultTextFormField(
                        controller: descriptionController,
                        hintText: 'Enter task description',
                        validator: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return 'Description can not empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16,),
                      Text('Selected Data',
                        style: titlMediumStyle?.copyWith(
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 8,),
                      InkWell(
                        onTap: () async {
                          DateTime? dataTime = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                            initialDate: selectedDate,
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                          );
                          if (dataTime != null && dataTime != selectedDate) {
                            selectedDate = dataTime;
                            setState(() {});
                          }
                        },
                        child:
                        Text(dateFormat.format(selectedDate)
                        ),
                      ),
                      SizedBox(height: 16,),
                      DefaultElevatedButton(
                          lable: 'Update',
                          onPressed: () async{
                            String newtitle = titleController.text;
                            String newdescription = descriptionController.text;
                            if (formKey.currentState!.validate()) {
                              String userId = Provider.of<UserProvider>(context,listen: false).currentUser!.id;
                              FirebaseFunctions.updateTaskFromFirestore(
                                  widget.taskId, userId, newtitle, newdescription)
                                  .then((_){
                                Navigator.of(context).pop();
                                Provider.of<TaskProvider>(context, listen: false).getTasks(userId);
                                Fluttertoast.showToast(
                                  msg: "Task added successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 5,
                                  backgroundColor: AppTheme.green,
                                );
                              },
                              )
                                  .catchError(
                                      (error){
                                    Fluttertoast.showToast(
                                      msg: "Some Thing Went Wrong",
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: AppTheme.red,
                                    );
                                  });
                            }
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
