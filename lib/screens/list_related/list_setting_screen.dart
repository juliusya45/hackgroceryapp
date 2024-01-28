import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/lists.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/group_related/groups_screen.dart';
import 'package:hack_grocery_app/screens/group_related/individual_group_screen.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';
import 'package:clipboard/clipboard.dart';

class ListSettingScreen extends StatefulWidget {
  const ListSettingScreen({super.key, required this.list, required this.group, required this.appUser});

  final AppUser appUser;
  final Group group;
  final Lists list;

  @override
  State<ListSettingScreen> createState() => _ListSettingScreenState();
}

class _ListSettingScreenState extends State<ListSettingScreen> {

  Future<void> removeList(Lists list, Group group) async
  {
    //add the reference to the db
    final db = FirebaseFirestore.instance;
    //reference the user from the users collection
    final docRef = db
    .collection("groups")
    .withConverter(
      fromFirestore: Group.fromFirestore,
      toFirestore: (Group group, option) => group.toFirestore(),
    )
    .doc(group.id);
    group.removeList(list.id);

    //this method updates the group to not have that list anymore:
    await docRef.set(group);
    //we aren't going to delete the list from the db
  }

  final _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var group = widget.group;
    var list = widget.list;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text(list.name),
      // title: Text(_groupNameController.text.trim()),
      centerTitle: true,
      
  ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            
            child: Column(
               
        crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Takes in email input
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(35),
                      child: SizedBox(
                        width: 250,
                        child: TextField(
                          controller: _groupNameController,
                          decoration: InputDecoration(
                            hintText: "Change List Name"
                          ),
                          obscureText: false,
                        ),
                      ),
                    ),
                    IconButton(onPressed: () => {},
       icon: Icon(Icons.drive_file_rename_outline_rounded)),
                  ],
                ),
      SizedBox(height: 20,),
      
      
       SizedBox(height: 450),
       ElevatedButton(
        onPressed: () {
          //add function here to delete group id from user:
          
          removeList(list, group);
          Navigator.pushAndRemoveUntil(
            context,   
            MaterialPageRoute(builder: (BuildContext context) => IndividualGroupScreen(listsList: [], group: group, appUser: widget.appUser,)), 
            ModalRoute.withName('/group_screen') // Replace this with your root screen's route name (usually '/')
        );
        },
        style: ElevatedButton.styleFrom(
        primary: Colors.red, // Background color
        onPrimary: Colors.white,
        ),
        child: const Text(
            'Delete List',
        style: TextStyle(fontSize: 20),
      ),
    )
              ],
            

       
        
      ),
      ),
    )
      ),
    );
    
  }
}