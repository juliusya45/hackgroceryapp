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
  const CreateItem({super.key, required this.list});

  final Lists list;

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {

  final _itemNameController = TextEditingController();
  final _itemDescController = TextEditingController();

  Future<void> createItem(Item item, Lists list) async
  {
    //add the item
    final db = FirebaseFirestore.instance;
    final docRef = db
    .collection("item")
    .withConverter(
      fromFirestore: Item.fromFirestore,
      toFirestore: (Item item, option) => item.toFirestore(),
    )
    .doc();
    //this method actually adds the list
    await docRef.set(item);

    //add the item id to the list
    list.addItem(docRef.id);
    final listsRef = db.collection("list").withConverter(
      fromFirestore: Lists.fromFirestore, toFirestore: (Lists list, option) => list.toFirestore()
      ).doc(list.id);
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
            controller: _itemNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            hintText: "Enter Item Name"
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(25),
            child: TextFormField(
            controller: _itemDescController,
            decoration: InputDecoration(
            hintText: "Item Description"
          ),
        ),
      ),
        ElevatedButton(
        onPressed : () {
          //create an item first and then pass that into our function
          var item = Item(name: _itemNameController.text.trim(), id: '', description: _itemDescController.text.trim(),);
          createItem(item, list);
          print('item created!');
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