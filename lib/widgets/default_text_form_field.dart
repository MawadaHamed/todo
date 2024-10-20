import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
   TextEditingController controller = TextEditingController();
      String hintText;
   String? Function(String?)? validator;
  DefaultTextFormField({required this.controller,required this.hintText, this.validator});


  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText
      ),
      validator:validator,
    );
  }
}
