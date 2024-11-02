import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/models/task_model.dart';
import 'package:untitled1/models/user_model.dart';

class FirebaseFunctions {

  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
        fromFirestore: (docSnapshot,options) =>
            UserModel.fromJson(docSnapshot.data()!) ,
        toFirestore: (userModel,_) => userModel.toJson(),
      );

  static CollectionReference<TaskModel> getTasksCollection(String userId) =>
      getUsersCollection().doc(userId).
      collection('tasks').withConverter<TaskModel>(
      fromFirestore: (docSnapshot,options) =>
      TaskModel.fromJson(docSnapshot.data()!) ,
      toFirestore: (taskModel,_) => taskModel.toJson(),
  );

  static Future<void> addTask(TaskModel task, String userId){
   CollectionReference<TaskModel> tasksCollection =  getTasksCollection(userId);
   DocumentReference<TaskModel> doc = tasksCollection.doc();
   task.id = doc.id;
   return doc.set(task);
  }

  static Future<List<TaskModel>> getAllTask(String userId) async{
    CollectionReference<TaskModel> tasksCollection =  getTasksCollection(userId);
    QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTaskFromFirestore(String taskId,String userId) async{
    CollectionReference<TaskModel> tasksCollection =  getTasksCollection(userId);
    return tasksCollection.doc(taskId).delete();
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password
  }) async{
   UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
   UserModel user = UserModel(
       id: credential.user!.uid,
       name: name,
       email: email
   );
   CollectionReference<UserModel> usersCollection =  getUsersCollection();
   await usersCollection.doc().set(user);
   return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
}) async{
    UserCredential credential =
     await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    CollectionReference<UserModel> usersCollection =  getUsersCollection();
    DocumentSnapshot<UserModel> docSnapshot =
    await usersCollection.doc(credential.user!.uid).get();
    return docSnapshot.data()!;
  }
   static Future<void> logout() => FirebaseAuth.instance.signOut();
}