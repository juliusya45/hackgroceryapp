import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';

class JoinGroup extends StatefulWidget {
  const JoinGroup({super.key, required this.appUser});
  final AppUser appUser;

  @override
  State<JoinGroup> createState() => _JoinGroupState();
}



class _JoinGroupState extends State<JoinGroup> {

  
  final _groupCodeController = TextEditingController();

  Future<void> joinGroup(AppUser appUser, String code) async
  {
    //add the reference to the db
    final db = FirebaseFirestore.instance;
    //reference the user from the users collection
    final docRef = db
    .collection("users")
    .withConverter(
      fromFirestore: AppUser.fromFirestore,
      toFirestore: (AppUser user, option) => user.toFirestore(),
    )
    .doc(FirebaseAuth.instance.currentUser!.uid);
    print("This is the code that was entered: " + code);
    //add the group to the user object
    appUser.addGroup(code);

    //this method adds the group to the user:
    await docRef.set(appUser);
  }

  @override
  Widget build(BuildContext context) {
    AppUser appUser = widget.appUser;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text('Join Group'),
      centerTitle: true,
  ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ 
        Padding(
          padding: const EdgeInsets.all(25),
            child: TextField(
            controller: _groupCodeController,
            decoration: InputDecoration(
            hintText: "Enter Group Code"
          ),
        ),
      ),
        ElevatedButton(
        onPressed : () {
          //code to make joining a group happen goes here!
          joinGroup(appUser, _groupCodeController.text.trim());
          Navigator.pop(context);
        },
        child: Text('Join!'),
          ),
        ],
      ),
      ),
    );
  }
}