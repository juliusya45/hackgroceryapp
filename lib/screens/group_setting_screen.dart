import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';

class GroupSettingScreen extends StatefulWidget {
  const GroupSettingScreen({super.key});

  @override
  State<GroupSettingScreen> createState() => _GroupSettingScreenState();
}

class _GroupSettingScreenState extends State<GroupSettingScreen> {

  final _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text(_groupNameController as String),
      centerTitle: true,
      actions: [
      IconButton(onPressed: () => {},
       icon: Icon(Icons.drive_file_rename_outline_rounded)),
    ],
  ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ 
        ElevatedButton(
        onPressed : () {},
        child: Text('Leave Group'),
        style: ElevatedButton.styleFrom(
          primary: Color.red,
        )
        backgroundColor: Color.red[600],
          ),
        ),
        ],
      ),
      ),
    );
  }
}