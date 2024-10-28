import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled1/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
      fromFirestore: (docSnapshot,options) =>
      TaskModel.fromJson(docSnapshot.data()!) ,
      toFirestore: (taskModel,_) => taskModel.toJson(),
  );

  static Future<void> addTask(TaskModel task){
   CollectionReference<TaskModel> tasksCollection =  getTasksCollection();
   DocumentReference<TaskModel> doc = tasksCollection.doc();
   task.id = doc.id;
   return doc.set(task);
  }

  static Future<List<TaskModel>> getAllTask() async{
    CollectionReference<TaskModel> tasksCollection =  getTasksCollection();
    QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }
}