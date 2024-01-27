import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/screens/authentication/auth_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingHome extends StatefulWidget {
  const LoadingHome({super.key});

  @override
  State<LoadingHome> createState() => _LoadingHomeState();
}

class _LoadingHomeState extends State<LoadingHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loading Home"),
      ),
      body: Center(
        child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
        LoadingAnimationWidget.prograssiveDots(
        color: Colors.black,
        size: 100),
          //this button is just for debugging, just in case we get stuck on this screen:
          ElevatedButton(
              child: Text("Sign Out"),
              
              onPressed:() {
                FirebaseAuth.instance.signOut();
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
              ),
          
        ],
        
      ),
      ),
    );
  }
}