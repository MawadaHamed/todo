import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/app_theme.dart';
import 'package:untitled1/auth/register_screen.dart';
import 'package:untitled1/auth/user_provider.dart';
import 'package:untitled1/firebase_function.dart';
import 'package:untitled1/home_screen.dart';
import 'package:untitled1/widgets/default_elevated-button.dart';
import 'package:untitled1/widgets/default_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        elevation: 0,
        title: Text(
          'Login'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextFormField(
                  controller: emailController,
                  hintText: 'Email',
                validator: (value){
                    if(value == null || value.trim().length < 5){
                      return 'Email can not be less than 5 characters';
                    }else{
                      return null;
                    }
                },
              ),
               SizedBox(height: 16,),
              DefaultTextFormField(
                  controller: passwordController,
                  hintText: 'Password',
                validator: (value){
                  if(value == null || value.trim().length < 8){
                    return 'Password can not be less than 8 characters';
                  }else{
                    return null;
                  }
                },
                isPassword: true,
              ),
              SizedBox(height: 32,),
              DefaultElevatedButton(
                  lable: 'Login',
                  onPressed: login
              ),
              SizedBox(height: 8,),
              TextButton(
                onPressed: ()=> Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName) ,
                child:Text(
                    'Do not Have an Account'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void login(){
    if(formKey.currentState!.validate()){
      FirebaseFunctions.login(
          email: emailController.text,
          password: passwordController.text
      ).then((user) {
        Provider.of<UserProvider>(context, listen: false).updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } ).catchError(
              (error){
            String? message;
            if(error is FirebaseAuthException) {
              message = error.message;
            }
            Fluttertoast.showToast(
              msg:message ?? "some thing went wrong",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 5,
              backgroundColor: AppTheme.red,
            );
          }
      );
    }
  }
}
