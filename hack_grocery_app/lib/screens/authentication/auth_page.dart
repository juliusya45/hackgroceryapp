import 'package:flutter/material.dart';
import 'package:hack_grocery_app/screens/authentication/login_screen.dart';
import 'package:hack_grocery_app/screens/authentication/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //want to initially show the login page
  bool showLoginPage = true;

  //when toggleScreens is called the state of the bool is switched
  //This is to faciliate changing between the sign up and sign in screen
  void toggleScreens()
  {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  //if showLoginPage is true show the login page, otherwise show the sign up page
  Widget build(BuildContext context) {
    if (showLoginPage)
    {
      return LoginScreen(showRegisterPage: toggleScreens);
    }
    else
    {
      return SignUpScreen(showLoginPage: toggleScreens);
    }
  }
}