import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/app_theme.dart';
import 'package:untitled1/auth/user_provider.dart';
import 'package:untitled1/firebase_function.dart';
import 'package:untitled1/models/task_model.dart';
import 'package:untitled1/tabs/tasks/add_task_bottom_sheet.dart';
import 'package:untitled1/tabs/tasks/task_provider.dart';
import 'package:untitled1/tabs/tasks/update_tassk.dart';


class TaskItem extends StatefulWidget {

  TaskItem(this.task);

  TaskModel task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                String userId = Provider
                    .of<UserProvider>(context, listen: false)
                    .currentUser!
                    .id;
                FirebaseFunctions.deleteTaskFromFirestore(widget.task.id, userId)
                    .then((_) {
                  Provider.of<TaskProvider>(context, listen: false).getTasks(
                      userId);
                }).catchError((_) {
                  Fluttertoast.showToast(
                    msg: "Task deleted successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 5,
                    backgroundColor: AppTheme.green,
                  );
                },
                );
              },
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children:  [
            SlidableAction(
              onPressed: (_) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTask(
                  taskId: widget.task.id,
                    oldTitle: widget.task.title,
                  oldDescription: widget.task.description,
                ),));
              },
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.white,
              icon: Icons.edit,
              label: 'Update',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                margin: EdgeInsetsDirectional.only(end: 12),
                color:widget.task.isDone? AppTheme.green : AppTheme.primary,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task.title,
                    style: textTheme.titleMedium?.copyWith(
                        color: widget.task.isDone? AppTheme.green : AppTheme.primary,),
                  ),
                  SizedBox(height: 4,),
                  Text(widget.task.description,
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 34,
                width: 69,
                decoration: BoxDecoration(
                  color:widget.task.isDone? AppTheme.green : AppTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                IconButton(onPressed:() {
                  widget.task.isDone = !widget.task.isDone;
                  String userId = Provider
                      .of<UserProvider>(context, listen: false)
                      .currentUser!
                      .id;
                  FirebaseFunctions.UpdateTaskStateFromFirestore(widget.task.id, userId,widget.task.isDone)
                      .then((_) {
                    Provider.of<TaskProvider>(context, listen: false).getTasks(
                        userId);
                  });
                },
                    icon:widget.task.isDone?Text('IsDone',style: TextStyle(
                      fontSize: 16
                    ),):
                    Icon (Icons.check,
                  color: AppTheme.white,
                  size: 32,)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
