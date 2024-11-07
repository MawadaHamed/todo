import 'package:flutter/material.dart';
import 'package:untitled1/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider with ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;
  String languageCode ='en';
  bool get isDark => themeMode == ThemeMode.dark;
  Color get backgroundImageName => isDark ? AppTheme.BackgroundDark: AppTheme.BackgroundLight ;


  void changeTheme(ThemeMode selectedTheme)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    themeMode = selectedTheme;
    pref.setBool('saveMode', isDark);
    notifyListeners();
  }
  void changeLanguage (String selectedLanguage)async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if(selectedLanguage == languageCode) return;
    languageCode = selectedLanguage;
    pref.setString('savelang', languageCode );
    notifyListeners();
  }
  void Mode()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    themeMode =( pref.getBool('saveMode')?? isDark ? ThemeMode.dark : ThemeMode.light);
    notifyListeners();
  }
  void language()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    languageCode = pref.getString('savelang') ?? languageCode ;
    notifyListeners();
  }
}