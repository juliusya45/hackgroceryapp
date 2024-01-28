import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/group_related/groups_screen.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';
import 'package:clipboard/clipboard.dart';

class GroupSettingScreen extends StatefulWidget {
  const GroupSettingScreen({super.key, required this.group, required this.appUser});

  final AppUser appUser;
  final Group group;

  @override
  State<GroupSettingScreen> createState() => _GroupSettingScreenState();
}

class _GroupSettingScreenState extends State<GroupSettingScreen> {

  Future<void> removeGroup(AppUser appUser, String code) async
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
    appUser.removeGroup(code);

    //this method updates the user in db to not have the group
    await docRef.set(appUser);

    //Now need to delete the group from the db
    final groupRef = db
    .collection('groups')
    .withConverter(
      fromFirestore: Group.fromFirestore,
      toFirestore: (Group group, option) => group.toFirestore(),
      )
      .doc(code);
    
    //to actually delete:
    groupRef.delete();
  }

  final _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appUser= widget.appUser;

      var group = widget.group;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text(group.name),
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
                            hintText: "Change Group Name"
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
      GestureDetector(
        child: Text("Group Code: " + group.id,
          style: TextStyle(fontSize: 18),
        ),
        onTap: (){
          FlutterClipboard.copy(group.id);
        },
        ),
      SizedBox(height: 10,),
      Text("Tap the code to copy & send!"),
      
       SizedBox(height: 400),
       ElevatedButton(
        onPressed: () {
          //add function here to delete group id from user:
          removeGroup(appUser, group.id);
          Navigator.pushAndRemoveUntil(
            context,   
            MaterialPageRoute(builder: (BuildContext context) => GroupScreen(groupsList: [], appUser: appUser,)), 
            ModalRoute.withName('/group_screen') // Replace this with your root screen's route name (usually '/')
        );
        },
        style: ElevatedButton.styleFrom(
        primary: Colors.red, // Background color
        onPrimary: Colors.white,
        ),
        child: const Text(
            'Leave Group',
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