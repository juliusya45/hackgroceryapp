import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';
import 'package:hack_grocery_app/classes/lists.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/classes/item.dart';


class CreateItem extends StatefulWidget {
  const CreateItem({super.key, required this.appUser, required this.list});

  final AppUser appUser;
  final Lists list;

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {

  final _listNameController = TextEditingController();

  Future<void> createGroup(Item item, Lists list) async
  {
    //add the list to the database:
    final db = FirebaseFirestore.instance;
    final docRef = db
    .collection("items")
    .withConverter(
      fromFirestore: Item.fromFirestore,
      toFirestore: (Item item, option) => item.toFirestore(),
    )
    .doc();
    //this method actually adds the list
    await docRef.set(item);

    //add the list to the group
    //what's actually happening is that I add the list to the group
    list.addItem(docRef.id);
    final listsRef = db.collection("list").withConverter(
      fromFirestore: Lists.fromFirestore, toFirestore: (Lists list, option) => list.toFirestore()
      ).doc(FirebaseAuth.instance.currentUser!.uid);
    await listsRef.set(list);

  }

  @override
  Widget build(BuildContext context) {
    final Lists list = widget.list;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text('Create New Item'),
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
            controller: _listNameController,
            decoration: InputDecoration(
            hintText: "Enter Item Name"
          ),
        ),
      ),
        ElevatedButton(
        onPressed : () {
          var item = Item(name: _listNameController.text.trim(), id: '', description: '',);
          createGroup(item, list);
        },
        child: Text('Create!'),
          ),
         ],
      ),
      ),
    );
  }
}