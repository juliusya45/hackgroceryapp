import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/firebase_options.dart';
import 'package:hack_grocery_app/screens/authentication/login_screen.dart';
import 'package:hack_grocery_app/screens/authentication/signup_screen.dart';
import 'package:hack_grocery_app/screens/groups_screen.dart';
import 'package:hack_grocery_app/screens/loading_screens/initial_screen.dart';
import 'package:hack_grocery_app/screens/loading_screens/loading_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Inter',),
      initialRoute: '/',
      routes: {
        //now goes to initialscreen and this checks to see if a user was logged in or not
        '/': (context) => const InitialScreen(),
        '/groups': (context) => const GroupScreen()
      },
    );
  }
}