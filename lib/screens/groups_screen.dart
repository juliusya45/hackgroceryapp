import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group_card.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';
import 'package:hack_grocery_app/classes/group.dart';

var emptyGroup = Group(color: 'ff32a852', id: '', name: 'Tests', imgUrl: '');
class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const GroupScreen(),
    );
  }
}

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text('Groups'),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: <Widget>[
      Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: Icon(
            Icons.more_vert
            ),
          )
        ),
      ],  
    ),
      body:
      ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(4.0),
            child: GroupCard(groupItem: emptyGroup),
          )
        ]
      ),
  floatingActionButton: const FloatingActionButton(
              child: Icon(Icons.add_box_outlined),
              onPressed: (null),
      )
    );
  }
}