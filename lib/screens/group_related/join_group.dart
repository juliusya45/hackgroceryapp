import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';

class JoinGroup extends StatefulWidget {
  const JoinGroup({super.key});

  @override
  State<JoinGroup> createState() => _JoinGroupState();
}



class _JoinGroupState extends State<JoinGroup> {

  final _groupCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        onPressed : () {},
        child: Text('Join!'),
          ),
        ],
      ),
      ),
    );
  }
}