import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
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
      //home: const IndividualGroupScreen(listsList: [],),
    );
  }
}

class IndividualGroupScreen extends StatefulWidget {
  const IndividualGroupScreen({super.key, required this.listsList, required this.group});

  final Group group;
  final List<Lists> listsList;

  @override
  State<IndividualGroupScreen> createState() => _IndividualGroupScreenState();
}

class _IndividualGroupScreenState extends State<IndividualGroupScreen> {
  @override
  Widget build(BuildContext context) {
    //this is a list of lists objects
    List<Lists> listsList = widget.listsList;

    //refresh method to allow user to refresh page:
    // Future<void> refresh() async
    // {
    //   //!!ALL OF THIS IS SAME AS IN LOADING_HOME!!
    //   //first remove everything currently in the list
    //   listsList.removeRange(0, listsList.length);
    //   var database = FirebaseFirestore.instance;
    //     //create a reference to the db:
    //     //defining the reference to our database:
    //   final specificGroupRef = database.collection('groups').withConverter(
    //   fromFirestore:  Group.fromFirestore,
    //   toFirestore: (Group groups, _) => groups.toFirestore(),
    //   ).doc(widget.group.id);
    //   //once data populates from the database fill the list
    //   //of groups with groups that the user can access
    //   await specificGroupRef.get().then((docSnapshot)
    //   {
    //     print("start getting lists");
    //     for(var lists in docSnapshot.)
    //     {
    //       print("getting lists!");
    //       final groups = doc.data();
    //       print(doc.id);
    //       print(appUser.groups.contains(doc.id));
    //       if(groups != null && appUser.groups.contains(doc.id))
    //       {
    //           //giving the groups object an id since it was left out originally
    //           groups.id = doc.id;
    //           print(groups.id);
    //           groupsList.add(groups);
    //       }
    //     }
    //   },
    //   onError: (e) => print(e)
    //   );
    //   setState(() {
        
    //   });
    // }

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