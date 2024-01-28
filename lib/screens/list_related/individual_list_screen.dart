import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/list_related/create_list_screen.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/nav_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';

//This screen is used when a list is clicked. Shows items

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    var empty = AppUser(email: '', uid: '', username: '', groups: []);

    return MaterialApp(
      home: IndividualListScreen(groupsList: [], appUser: empty,),
      theme: ThemeData(useMaterial3: true)
    );
  }
}

class IndividualListScreen extends StatefulWidget {

  const IndividualListScreen({super.key, required this.groupsList, required this.appUser});
  final List<Group> groupsList;
  final AppUser appUser;
  
  @override
  State<IndividualListScreen> createState() => _IndividualListScreenState();
}

class _IndividualListScreenState extends State<IndividualListScreen> {
  @override
  Widget build(BuildContext context) {
    final AppUser appUser = widget.appUser;
    final List<Group> groupsList = widget.groupsList;
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
  floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add_box_outlined),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => CreateList(group:  groupsList[0]))));
              }
      )
    );
  }
}