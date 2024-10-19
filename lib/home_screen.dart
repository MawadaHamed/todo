import 'package:flutter/material.dart';
import 'package:untitled1/app_theme.dart';
import 'package:untitled1/tabs/settings/setting_tab.dart';
import 'package:untitled1/tabs/tasks/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [
    TaskTab(),
    SettingTab(),
  ];
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: EdgeInsets.zero,
          color: AppTheme.white,
          child: BottomNavigationBar(
            currentIndex: currentTabIndex,
              onTap: (index) => setState(() =>
                currentTabIndex = index),
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  label: 'Tasks',
                    icon: Icon(Icons.list,
                    size: 32,)
                ),
                BottomNavigationBarItem(
                    label: 'Setting',
                    icon: Icon(Icons.settings,
                    size: 32,),
                ),
              ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
         onPressed: () {},
        child: Icon(Icons.add,
        size: 23,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
