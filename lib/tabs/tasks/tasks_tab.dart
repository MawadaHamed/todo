import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/app_theme.dart';
import 'package:untitled1/tabs/tasks/task_item.dart';



class TaskTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
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
                  'ToDo List',
                style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(color: AppTheme.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * .11),
              child: EasyInfiniteDateTimeLine(
                firstDate:DateTime.now().subtract(Duration(days: 365)),
                focusDate: DateTime.now(),
                lastDate:DateTime.now().add(Duration(days: 365)),
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
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 20),
            itemBuilder: (_,index) =>TaskItem(),
          itemCount: 10,),
        )
      ],
    );
  }
}
