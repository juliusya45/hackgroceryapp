import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/authentication/auth_page.dart';
import 'package:hack_grocery_app/screens/authentication/verification_screen.dart';
import 'package:hack_grocery_app/screens/loading_screens/loading_home.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key, required this.groupsList, required this.appUser});

  final List<Group> groupsList;
  final AppUser appUser;

  @override
  State<InitialScreen> createState() => __InitialScreenState();
}

class __InitialScreenState extends State<InitialScreen> {
  
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
          {
            if(FirebaseAuth.instance.currentUser!.emailVerified)
            {
              if (kDebugMode) {
                print('to home screen');
              }
              //if the user successfully signed in we show a loading spinner and do everything else
              return LoadingHome();
            }
            //if the user has not been verified
            else
            {
              //else we send the user to the verification page to be verified
              if (kDebugMode) {
                print('to verification page');
              }
              return const VerificationScreen();
            }
            //in the future a check to make sure a user isn't blacklisted should also occur, but for now that's not important to implement
          }
          else
          {
            if (kDebugMode) {
              print('to login page');
            }
            //auth page is another inbetween that switches between login and register page
            return AuthScreen();
          }
        },
      ),
    );
  }
}