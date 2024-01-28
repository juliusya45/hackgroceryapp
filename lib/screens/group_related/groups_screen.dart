import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group_card.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/group_related/create_group.dart';
import 'package:hack_grocery_app/screens/group_related/join_group.dart';
import 'package:hack_grocery_app/screens/group_related/individual_group_screen.dart';
import 'package:hack_grocery_app/classes/lists.dart';

var list1 = Lists(color:'ff95b1de', id: '', name: 'Test1', imgUrl: '', items: []);
var list2 = Lists(color:'ff1531ae', id: '', name: 'Test2', imgUrl: '', items: []);
var list3 = Lists(color:'ff51c11e', id: '', name: 'Test3', imgUrl: '', items: []);
List<Lists> listsList = [list1, list2, list3];  
class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppUser empty = AppUser(uid: '', username: '', email: '', groups: []);
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: GroupScreen(groupsList: [], appUser: empty ,),
    );
  }
}

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key, required this.groupsList, required this.appUser});

  final AppUser appUser;
  final List<Group> groupsList;

  @override
  State<GroupScreen> createState() => _GroupScreenState();

  
}

class _GroupScreenState extends State<GroupScreen> {
  final _key = GlobalKey<ExpandableFabState>();

   //refresh method to allow user to refresh page:
    Future<void> refresh() async
    {
        //this is a list of group objects
      List<Group> groupsList = widget.groupsList;
      AppUser appUser = widget.appUser;
      //!!ALL OF THIS IS SAME AS IN LOADING_HOME!!
      //first remove everything currently in the list
      groupsList.removeRange(0, groupsList.length);
      var database = FirebaseFirestore.instance;
        //create a reference to the db:
        //defining the reference to our database:
      final groupRef = database.collection('groups').withConverter(
      fromFirestore:  Group.fromFirestore,
      toFirestore: (Group groups, _) => groups.toFirestore(),
      );
      //once data populates from the database fill the list
      //of groups with groups that the user can access
      await groupRef.get().then((querySnapshot)
      {
        print("start getting groups");
        for(var doc in querySnapshot.docs)
        {
          print("getting groups!");
          final groups = doc.data();
          print(doc.id);
          //add id to group:
          groups.id = doc.id;
          print(appUser.groups.contains(doc.id));
          if(groups != null && appUser.groups.contains(doc.id))
          {
              //giving the groups object an id since it was left out originally
              groups.id = doc.id;
              print(groups.id);
              groupsList.add(groups);
          }
        }
      },
      onError: (e) => print(e)
      );
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
    //this is a list of group objects
    List<Group> groupsList = widget.groupsList;
    AppUser appUser = widget.appUser;

   
    

    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.green,
      title: Text('Groups'),
      centerTitle: true,
      automaticallyImplyLeading: false,
      // actions: <Widget>[
      // Padding(
      // padding: EdgeInsets.only(right: 20.0),
      // child: GestureDetector(
      //   onTap: () {},
      //   child: Icon(
      //       Icons.more_vert
      //       ),
      //     )
      //   ),
      // ],  
    ),
      body:
      RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder
        (
          itemCount: groupsList.length,
          itemBuilder: (context, index)
          {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              child: Card(
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => IndividualGroupScreen(listsList: [], group: groupsList[index], appUser: appUser,))));
                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        refresh();
                      });
                    });
                  },
                  child: GroupCard(groupItem: groupsList[index]),
                ),
              ),
              );
          }
        ),
      ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
        key: _key,
        // duration: const Duration(milliseconds: 500),
        distance: 70.0,
        type: ExpandableFabType.up,
        pos: ExpandableFabPos.right,
        // childrenOffset: const Offset(0, 20),
        // fanAngle: 40,
        // openButtonBuilder: RotateFloatingActionButtonBuilder(
        //   child: const Icon(Icons.abc),
        //   fabSize: ExpandableFabSize.large,
        //   foregroundColor: Colors.amber,
        //   backgroundColor: Colors.green,
        //   shape: const CircleBorder(),
        //   angle: 3.14 * 2,
        // ),
        // closeButtonBuilder: FloatingActionButtonBuilder(
        //   size: 56,
        //   builder: (BuildContext context, void Function()? onPressed,
        //       Animation<double> progress) {
        //     return IconButton(
        //       onPressed: onPressed,
        //       icon: const Icon(
        //         Icons.check_circle_outline,
        //         size: 40,
        //       ),
        //     );
        //   },
        // ),
        overlayStyle: ExpandableFabOverlayStyle(
          blur: 5,
        ),
        onOpen: () {
          debugPrint('onOpen');
        },
        afterOpen: () {
          debugPrint('afterOpen');
        },
        onClose: () {
          debugPrint('onClose');
        },
        afterClose: () {
          debugPrint('afterClose');
        },
        children: [
          FloatingActionButton.extended(
            // shape: const CircleBorder(),
            heroTag: null,
            icon: const Icon(Icons.add),
            tooltip: "Create Group",
            label: const Text('Create Group'),
            mouseCursor: MaterialStateMouseCursor.textable,
            onPressed: ()  async {
              await Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateGroup(appUser: appUser)));
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  refresh();
                });
              });
            }
          ),
          FloatingActionButton.extended(
            // shape: const CircleBorder(),
            heroTag: null,
            mouseCursor: MaterialStateMouseCursor.textable,
            tooltip: "Add Group",
            label: const Text('Add Group'),
            icon: const Icon(Icons.group_add),
            onPressed: ()
              async {
              await Navigator.push(context, MaterialPageRoute(builder: (context)=> JoinGroup(appUser: appUser,)));
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  refresh();
                });
            });
              }
              ),
        ],
      ),
    );    
  }
}

