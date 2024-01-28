import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/item.dart';
import 'package:hack_grocery_app/classes/item_card.dart';
import 'package:hack_grocery_app/classes/lists.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/group_related/group_setting_screen.dart';
import 'package:hack_grocery_app/screens/item_related/create_item_screen.dart';
import 'package:hack_grocery_app/screens/list_related/list_setting_screen.dart';
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

  const IndividualListScreen({super.key, required this.list, required this.group, required this.appUser});
  final Lists list;
  final Group group;
  final AppUser appUser;
  
  @override
  State<IndividualListScreen> createState() => _IndividualListScreenState();
}

class _IndividualListScreenState extends State<IndividualListScreen> {
  //list to hold items that are in this list
  List<Item> items = [];

  //refresh method to allow user to refresh page:
  //and used to get items from db
    Future<void> refresh() async
    {
      //!!ALL OF THIS IS SAME AS IN LOADING_HOME!!
      //first remove everything currently in the list
      print('List id: ' + widget.list.id);
      items.removeRange(0, items.length);
      var database = FirebaseFirestore.instance;
        //create a reference to the db:
        //defining the reference to our database:
      final specificListRef = database.collection('list').doc(widget.list.id).withConverter(
      fromFirestore:  Lists.fromFirestore,
      toFirestore: (Lists list, _) => list.toFirestore(),
      );
      //once data populates from the database fill the list
      //of items that our list has

      final docSnap = await specificListRef.get();

      final listDoc = docSnap.data();

      //for every item that a list has
      for(var itemId in listDoc!.items)
      {
        //get that item from the db:
        final itemRef = database.collection('item').doc(itemId).withConverter(
      fromFirestore:  Item.fromFirestore,
      toFirestore: (Item item, _) => item.toFirestore(),
      );
        final itemSnap = await itemRef.get();
        //create the item object
        final item = itemSnap.data();
        //add that list
        print(item?.id);
        items.add(item!);
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
    //refresh when the user gets to this screen
    refresh();
  }


  @override
  Widget build(BuildContext context) {
    final bool check = false;
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
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context)=> ListSettingScreen(list: list, group: widget.group, appUser: widget.appUser,)));
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
          //build an item card for each item stored
          itemCount: items.length,
          itemBuilder: (context, index)
          {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              child: Card(
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    //this is where code would go to get a detailed menu to show for each item
                  },
                  child: ItemCard(itemInst: items[index]),
                ),
              ),
              );
          }
        ),
      ),
  floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add_box_outlined),
              onPressed: () async {
              //when the add item button is created go to the screen to add an item
              await Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateItem(list: list,)));
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  refresh();
                });
              });
              }
      )
    );
  }
}