import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/group_card.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/firebase_options.dart';
import 'package:hack_grocery_app/screens/authentication/login_screen.dart';
import 'package:hack_grocery_app/screens/authentication/signup_screen.dart';
import 'package:hack_grocery_app/screens/authentication/verification_screen.dart';
import 'package:hack_grocery_app/screens/groups_Setting_Screen.dart';
import 'package:hack_grocery_app/screens/groups_setting_screen.dart';
import 'package:hack_grocery_app/screens/groups_screen.dart';
import 'package:hack_grocery_app/screens/loading_screens/initial_screen.dart';
import 'package:hack_grocery_app/screens/loading_screens/loading_home.dart';
import 'package:hack_grocery_app/screens/nav_screen.dart';
import 'package:hack_grocery_app/screens/main_setting_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';



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

    //objects that hold empty data:
    var emptyGroup = Group(color: '', id: '', name: '', imgUrl: '');
    var emptyUser = AppUser(uid: '', username: '', email: '', groups: []);



    return MaterialApp(
      theme: ThemeData(fontFamily: 'Inter',useMaterial3: true),
      initialRoute: '/',
      routes: {
        //now goes to initialscreen and this checks to see if a user was logged in or not
        '/': (context) => const InitialScreen(),
        '/nav': (context) => const Nav(),
        '/verification': (context) => const VerificationScreen(),
        '/loading_home': (context) => const LoadingHome(),
        '/group_card': (context) => GroupCard(groupItem: emptyGroup),
      },
    );
  }
}
