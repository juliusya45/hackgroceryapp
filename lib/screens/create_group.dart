import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  final _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        onPressed : () {},
        child: Text('Create!'),
          ),
        ],
      ),
      ),
    );
  }
}