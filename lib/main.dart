import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/app_theme.dart';
import 'package:untitled1/auth/login_screen.dart';
import 'package:untitled1/auth/register_screen.dart';
import 'package:untitled1/auth/user_provider.dart';
import 'package:untitled1/home_screen.dart';
import 'package:untitled1/tabs/settings/setting_provider.dart';
import 'package:untitled1/tabs/tasks/task_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:untitled1/tabs/tasks/update_tassk.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(providers: [
        ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        ),
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => SettingProvider(),
      ),
    ],
        child: TodoApp(),)
  );
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName:(_) => HomeScreen(),
        LoginScreen.routeName:(_) => LoginScreen(),
        RegisterScreen.routeName:(_) => RegisterScreen(),
      },
      initialRoute: LoginScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingProvider.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingProvider.languageCode),
    );
  }
}
