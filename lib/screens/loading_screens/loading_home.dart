import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/authentication/auth_page.dart';

class LoadingHome extends StatefulWidget {
  const LoadingHome({super.key});

  @override
  State<LoadingHome> createState() => _LoadingHomeState();
}

class _LoadingHomeState extends State<LoadingHome> {
  //defining database
  final database = FirebaseFirestore.instance;
  List<Group> allGroups = [];
  late AppUser sendUser;

  Future<void> setup() async{
    //defining the reference to our database:
    final ref = database.collection('groups').orderBy('time').withConverter(
    fromFirestore:  Group.fromFirestore,
    toFirestore: (Group groups, _) => groups.toFirestore(),
    );

    //once data populates from the database fill the list
    //of groups with groups that the user can access
    await ref.get().then((event)
    {
      for(var doc in event.docs)
      {
        final groups = doc.data();
        if(groups != null && groups.id == sendUser.groups.contains(groups.id))
        {
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loading Home"),
      ),
      body:  Column(
        children: [
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
          Text("this would be the page where the user's data is preloaded"),
          Text("before the groups screen is shown")
        ],
      ),
    );
  }
}