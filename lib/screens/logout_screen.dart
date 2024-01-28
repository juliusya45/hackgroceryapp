import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hack_grocery_app/screens/authentication/auth_page.dart';


class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const SettingScreen(),
    );
  }
}

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            ),
        ),
        centerTitle: true,
      ),
      body: ListView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            children: [
              ElevatedButton(
                child: const Text('Log Out'),
                onPressed: () {
                  //signs user out
                  FirebaseAuth.instance.signOut();
                  //Animation that puts the user back onto the login screen
                  //from: https://stackoverflow.com/questions/55586189/flutter-log-out-replace-stack-beautifully
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                        Animation secondaryAnimation) {
                          //switch to Authpage?
                      return const AuthScreen();
                    },
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    }),
                    (route) => false
                    );
                },
              )
            ],
          ),
    );
  }
}