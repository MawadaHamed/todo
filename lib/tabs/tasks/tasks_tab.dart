import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/app_theme.dart';
import 'package:untitled1/auth/user_provider.dart';
import 'package:untitled1/tabs/tasks/task_item.dart';
import 'package:untitled1/tabs/tasks/task_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class TaskTab extends StatefulWidget {

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  bool shouldGetTasks = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    String userId = Provider.of<UserProvider>(context,listen: false).currentUser!.id;
   if(shouldGetTasks){
     taskProvider.getTasks(userId);
      shouldGetTasks = false;
    }

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: height * .17,
              width: double.infinity,
              color: AppTheme.primary,
            ),
            PositionedDirectional(
              start: 20,
              child: SafeArea(
                child: Text(
                  AppLocalizations.of(context)!.todoList,
                style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(color: AppTheme.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * .11),
              child: EasyInfiniteDateTimeLine(
                firstDate:DateTime.now().subtract(Duration(days: 365)),
                focusDate: taskProvider.selectedDate,
                lastDate:DateTime.now().add(Duration(days: 365)),
                onDateChange: (selectedDate){
                  taskProvider.getSelectedDateTasks(selectedDate,userId);
                },
                showTimelineHeader: false,
                dayProps: EasyDayProps(
                  height: 79,
                  width: 58,
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle:DayStyle(
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.all(Radius.circular(5),)
                    ),
                    dayNumStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                    dayStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ) ,
                  inactiveDayStyle:DayStyle(
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.all(Radius.circular(5),)
                    ),
                    dayNumStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.black,
                    ),
                    dayStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.black,
                    ),
                  ),
                  todayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.all(Radius.circular(5),)
                    ),
                    dayNumStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                    dayStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ) ,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 20),
            itemBuilder: (_,index) =>TaskItem(taskProvider.tasks[index]),
          itemCount:taskProvider.tasks.length,),
        )
      ],
    );
  }
}
