import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/group_related/group_setting_screen.dart';
import 'package:hack_grocery_app/screens/list_related/create_list_screen.dart';
import 'package:hack_grocery_app/screens/item_related/individual_list_screen.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';
import 'package:hack_grocery_app/classes/list_card.dart';
import 'package:hack_grocery_app/classes/lists.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

//This screen is to show multiple lists once you tap a group


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

  //refresh method to allow user to refresh page:
    Future<void> refresh() async
    {
      //!!ALL OF THIS IS SAME AS IN LOADING_HOME!!
      //first remove everything currently in the list
      widget.listsList.removeRange(0, widget.listsList.length);
      var database = FirebaseFirestore.instance;
        //create a reference to the db:
        //defining the reference to our database:
      final specificGroupRef = database.collection('groups').doc(widget.group.id).withConverter(
      fromFirestore:  Group.fromFirestore,
      toFirestore: (Group groups, _) => groups.toFirestore(),
      );
      //once data populates from the database fill the list
      //of lists that a group has

      final docSnap = await specificGroupRef.get();

      final listGroup = docSnap.data();

      //for every list that a group has
      for(var listId in listGroup!.lists)
      {
        //get that list from the db:
        final listRef = database.collection('list').doc(listId).withConverter(
      fromFirestore:  Lists.fromFirestore,
      toFirestore: (Lists list, _) => list.toFirestore(),
      );
        final listSnap = await listRef.get();
        //create the list object
        final list = listSnap.data();
        //add id to list:
        list?.id = listSnap.id;
        //add that list
        print(list?.id);
        widget.listsList.add(list!);
      }
      onError: (e) => print(e);
      //just refresh the entire screen
      setState(() {
        
      });
    }

    @override
    void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    //this is a list of lists objects
    List<Lists> listsList = widget.listsList;

    

    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text(widget.group.name),
      centerTitle: true,
      actions: <Widget>[
      Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context)=> GroupSettingScreen(group: widget.group,)));
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  refresh();
                });
              });
        },
        child: Icon(
            Icons.more_vert
            ),
          )
        ),
      ],  
    ),
      body:
      RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder
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
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => IndividualListScreen(list: listsList[index]))));
                  },
                  child: ListCard(listItem: listsList[index]),
                ),
              ),
              );
          }
        ),
      ),
  floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add_box_outlined),
              onPressed: ()  async {
              await Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateList(group: widget.group)));
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  refresh();
                });
              });
            },
      )
    );
  }
}