import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
   TextEditingController controller = TextEditingController();
      String hintText;
   String? Function(String?)? validator;
   bool isPassword;
  DefaultTextFormField({
    required this.controller,
    required this.hintText,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
 late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon:widget.isPassword?
        IconButton(
            onPressed: (){
              isObscure = !isObscure;
              setState(() {});
            },
            icon: Icon(
              isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            )
    ): null,
      ),
      validator:widget.validator,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
