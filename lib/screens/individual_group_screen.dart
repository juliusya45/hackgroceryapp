import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/screens/individual_list_screen.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';
import 'package:hack_grocery_app/classes/list_card.dart';
import 'package:hack_grocery_app/classes/lists.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();


class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const IndividualGroupScreen(listsList: [],),
    );
  }
}

class IndividualGroupScreen extends StatefulWidget {
  const IndividualGroupScreen({super.key, required this.listsList});

  final List<Lists> listsList;

  @override
  State<IndividualGroupScreen> createState() => _IndividualGroupScreenState();
}

class _IndividualGroupScreenState extends State<IndividualGroupScreen> {
  @override
  Widget build(BuildContext context) {
    //this is a list of lists objects
    List<Lists> listsList = widget.listsList;

    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text('Lists'),
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
      body:
      ListView.builder
      (
        itemCount: listsList.length,
        itemBuilder: (context, index)
        {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            child: Card(
              elevation: 3,
              child: InkWell(
                onTap: () {
                  //function to view the corresponding group
                },
                child: ListCard(listItem: listsList[index]),
              ),
            ),
            );
        }
      ),
  floatingActionButton: const FloatingActionButton(
              child: Icon(Icons.add_box_outlined),
              onPressed: (null),
      )
    );
  }
}