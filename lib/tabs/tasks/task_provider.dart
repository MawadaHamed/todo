import 'package:flutter/cupertino.dart';
import 'package:untitled1/firebase_function.dart';
import 'package:untitled1/models/task_model.dart';

class TaskProvider with ChangeNotifier{
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getTasks(String userId) async{
   List<TaskModel> allTasks = await FirebaseFunctions.getAllTask(userId);
    tasks = allTasks.where(
            (task) =>
                task.date.year == selectedDate.year &&
                task.date.month == selectedDate.month &&
                task.date.day == selectedDate.day
    ).toList();
    notifyListeners();
  }
  void getSelectedDateTasks(DateTime date,String userId){
    selectedDate  = date;
    getTasks(userId);
  }

  void resetData(){
    tasks = [];
    selectedDate = DateTime.now();
  }
}