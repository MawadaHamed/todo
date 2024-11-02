import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/app_theme.dart';
import 'package:untitled1/firebase_function.dart';
import 'package:untitled1/models/task_model.dart';
import 'package:untitled1/tabs/tasks/task_provider.dart';


class TaskItem extends StatelessWidget {

  TaskItem(this.task);
  TaskModel task;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children:  [
            SlidableAction(
              onPressed: (_) {
                FirebaseFunctions.deleteTaskFromFirestore(task.id).timeout(
                    Duration(microseconds : 100),
                    onTimeout: (){
                      Provider.of<TaskProvider>(context, listen: false).getTasks();
                    }).catchError((_){},
                );
              },
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
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
                margin:EdgeInsetsDirectional.only(end: 12) ,
                color: AppTheme.primary,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title,
                  style: textTheme.titleMedium ?.copyWith(color: AppTheme.primary),
                  ),
                  SizedBox(height: 4,),
                  Text(task.description,
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 34,
                width: 69,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                Icon(Icons.check,
                color: AppTheme.white,
                  size: 32,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
