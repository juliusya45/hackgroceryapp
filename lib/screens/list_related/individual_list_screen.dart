import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/lists.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/item_related/create_item_screen.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/nav_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';

//This screen is used when a list is clicked. Shows items

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(useMaterial3: true)
    );
  }
}

class IndividualListScreen extends StatefulWidget {

  const IndividualListScreen({super.key, required this.list,});
  final Lists list;
  
  @override
  State<IndividualListScreen> createState() => _IndividualListScreenState();
}

class _IndividualListScreenState extends State<IndividualListScreen> {
  @override
  Widget build(BuildContext context) {
    final Lists list = widget.list;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text('Items'),
      centerTitle: true,
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
      body: Card(
      child: InkWell(
      onTap: () {},
      child: Container(
        
        width: 500.0,
        height: 150.0,
              
            ),
          ),
        ),
  floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add_box_outlined),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => CreateItem(list:  list))));
              }
      )
    );
  }
}