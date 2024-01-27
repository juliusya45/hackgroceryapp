import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hack_grocery_app/screens/authentication/auth_page.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verfication Screen"),
        ),
        body: ElevatedButton(
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
    );
  }
}