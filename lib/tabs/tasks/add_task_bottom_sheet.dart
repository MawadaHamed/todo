import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/widgets/default_elevated-button.dart';
import 'package:untitled1/widgets/default_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  var formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextStyle? titlMediumStyle = Theme.of(context).textTheme.titleMedium;
    return Container(
      height: MediaQuery.sizeOf(context).height * .5,
      padding: EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text('Add New Task',
            style: titlMediumStyle,
            ),
            const SizedBox(height: 16,),
            DefaultTextFormField(
              controller: titleController,
              hintText: 'Enter task title',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Title can not empty';
                }
                return null;
              },
            ),
            SizedBox(height: 16,),
            DefaultTextFormField(
              controller: descriptionController,
              hintText: 'Enter task description',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Description can not empty';
                }
                return null;
              },
            ),
            SizedBox(height: 16,),
            Text('Selected Data',
            style: titlMediumStyle?.copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8,),
            InkWell(
              onTap: () async{
              DateTime? dataTime = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  initialDate: selectedDate,
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                );
              if(dataTime != null && dataTime != selectedDate){
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
                lable: 'Add',
                onPressed:(){
                  if(formKey.currentState!.validate()){
                    addTask();
                  }
                })
          ],
        ),
      ),
    );
  }
  void addTask(){

  }
}
