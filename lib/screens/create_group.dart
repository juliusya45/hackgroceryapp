import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/lists.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key, required this.appUser});

  final AppUser appUser;

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  final _groupNameController = TextEditingController();

  Future<void> createGroup(Group group, AppUser appUser) async
  {
    //add the group to the database:
    final db = FirebaseFirestore.instance;
    final docRef = db
    .collection("groups")
    .withConverter(
      fromFirestore: Group.fromFirestore,
      toFirestore: (Group group, option) => group.toFirestore(),
    )
    .doc();
    //this method actually adds the group
    await docRef.set(group);

    //add the user to the group
    //what's actually happening is that I add the group to the user
    appUser.addGroup(docRef.id);
    final userRef = db.collection("users").withConverter(
      fromFirestore: AppUser.fromFirestore, toFirestore: (AppUser appuser, option) => appuser.toFirestore()
      ).doc(FirebaseAuth.instance.currentUser!.uid);
    await userRef.set(appUser);

  }

  @override
  Widget build(BuildContext context) {
    final AppUser appUser = widget.appUser;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text('Create Group'),
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
            controller: _groupNameController,
            decoration: InputDecoration(
            hintText: "Enter Group Name"
          ),
        ),
      ),
        ElevatedButton(
        onPressed : () {
          var group = Group(color: 'c77069', name: _groupNameController.text.trim(), id: '', lists: [],);
          createGroup(group, appUser);
          //after creating the group go back to the groups screen:
          Navigator.pop(context);
        },
        child: Text('Create!'),
          ),
        ],
      ),
      ),
    );
  }
}