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
      home: const IndividualGroupScreen(),
    );
  }
}

class IndividualGroupScreen extends StatefulWidget {
  const IndividualGroupScreen({super.key});

  @override
  State<IndividualGroupScreen> createState() => _IndividualGroupScreenState();
}

class _IndividualGroupScreenState extends State<IndividualGroupScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text('Group Name For Now'),
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
      body:Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home page',
                style: theme.textTheme.titleLarge,
              ),
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