import 'package:flutter/material.dart';

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
                  onPressed: (){},
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
