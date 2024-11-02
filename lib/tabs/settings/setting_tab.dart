import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/auth/login_screen.dart';
import 'package:untitled1/auth/user_provider.dart';
import 'package:untitled1/firebase_function.dart';
import 'package:untitled1/tabs/tasks/task_provider.dart';

class SettingTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LogOut',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: (){
                    FirebaseFunctions.logout();
                    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                    Provider.of<TaskProvider>(context,listen: false).resetData();
                    Provider.of<UserProvider>(context, listen: false).updateUser(null);
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 28,)
                  ,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
