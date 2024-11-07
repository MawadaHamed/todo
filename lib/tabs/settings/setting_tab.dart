import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/app_theme.dart';
import 'package:untitled1/auth/login_screen.dart';
import 'package:untitled1/auth/user_provider.dart';
import 'package:untitled1/firebase_function.dart';
import 'package:untitled1/tabs/settings/language.dart';
import 'package:untitled1/tabs/settings/setting_provider.dart';
import 'package:untitled1/tabs/settings/setting_tab.dart';
import 'package:untitled1/tabs/settings/setting_tab.dart';
import 'package:untitled1/tabs/tasks/task_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingTab extends StatefulWidget {

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {

  List<Language> languages =[
    Language(name: 'English', code: 'en'),
    Language(name: 'العربيه', code: 'ar')
  ];

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    double height = MediaQuery.sizeOf(context).height;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
       title: PositionedDirectional(
         start: 20,
         child: SafeArea(
           child: Text(
             AppLocalizations.of(context)!.settings,
             style: Theme.of(context).textTheme.titleMedium
                 ?.copyWith(color: AppTheme.white),
           ),
         ),
       ),
      ),

       body: Padding(
         padding: EdgeInsets.symmetric(horizontal: 20.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [

             SizedBox(height: 12,),
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
                     color: settingProvider.isDark ? AppTheme.white : Colors.black,
                     size: 28,)
                   ,)
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text( AppLocalizations.of(context)!.theme,
                   style: Theme.of(context).
                   textTheme.titleMedium
                       ?.copyWith(fontWeight: FontWeight.w500,
                     color: settingProvider.isDark ? AppTheme.white : Colors.black
                   ),
                 ),
                 Switch(
                   value:
                   settingProvider.isDark,
                   onChanged: (isDark) {
                     settingProvider
                         .changeTheme(isDark ? ThemeMode.dark : ThemeMode.light);
                   },
                   activeTrackColor: AppTheme.primary,
                 )
               ],
             ),
             SizedBox(height: 19,),

             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text( AppLocalizations.of(context)!.language,
                   style: Theme.of(context).
                   textTheme.titleMedium
                       ?.copyWith(fontWeight: FontWeight.w500),
                 ),
                 DropdownButtonHideUnderline(
                   child: DropdownButton<Language>(
                     value: languages.firstWhere((Language) =>
                     Language.code == settingProvider.languageCode),
                     items:languages.map((Language) =>
                         DropdownMenuItem(child:
                         Text(
                           Language.name,
                           style: Theme.of(context).textTheme.titleMedium,
                         ),
                           value: Language,
                         )
                     ).toList(),

                     onChanged: (selectedLanguage){
                       if(selectedLanguage != null) return
                         settingProvider.changeLanguage(selectedLanguage.code);
                       settingProvider.language();
                     },
                     borderRadius: BorderRadius.circular(20),
                     dropdownColor: settingProvider.isDark ?
                     AppTheme.BackgroundDark
                         : AppTheme.white,
                   ),
                 )
               ],
             ),

           ],
         ),
       )
      );
  }
}

