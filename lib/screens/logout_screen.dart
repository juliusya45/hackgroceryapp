import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/authentication/auth_page.dart';
import 'package:hack_grocery_app/screens/loading_screens/initial_screen.dart';


class NavigationBarApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  const NavigationBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            // Remove the debug banner
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.amber),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: const SettingScreen(),
          );
  });
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
    AppUser emptyUser = AppUser(uid: '', username: '', email: '', groups: []);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            ),
        ),
        actions: [
          IconButton(
              icon: Icon(NavigationBarApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                NavigationBarApp.themeNotifier.value =
                    NavigationBarApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              })
        ],
        centerTitle: true,
      ),
      body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                      return InitialScreen(groupsList: [], appUser: emptyUser,);
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
                    (route) => true
                    );
                },
              )
            ],
          ),
    );
  }
}