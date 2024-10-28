import 'package:flutter/material.dart';
import 'package:untitled1/app_theme.dart';

class DefaultElevatedButton extends StatelessWidget {
  DefaultElevatedButton({required this.lable,required this.onPressed});
  String lable;
  void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
          MediaQuery.sizeOf(context).width,52),
        ),
        child: Text(
          lable,
        style:
        Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400,
        color: AppTheme.white),
        ),
    );
  }
}
