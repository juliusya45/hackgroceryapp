import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';


class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const IndividualListScreen(),
    );
  }
}

class IndividualListScreen extends StatefulWidget {
  const IndividualListScreen({super.key});

  @override
  State<IndividualListScreen> createState() => _IndividualListScreenState();
}

class _IndividualListScreenState extends State<IndividualListScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text('List Name For Now'),
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
  floatingActionButton: const FloatingActionButton(
              child: Icon(Icons.add_box_outlined),
              onPressed: (null),
      )
    );
  }
}