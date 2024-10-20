class TaskModel {
  String id;
  String title;
  DateTime date;
  String description;
  bool isDone;


  TaskModel({
    this.id = '',
    required this.title,
  required this.date,
  required this.description,
   this.isDone = false,
});
}