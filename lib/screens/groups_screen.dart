import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group_card.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/screens/create_group.dart';
import 'package:hack_grocery_app/screens/join_group.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const GroupScreen(groupsList: [],),
    );
  }
}

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key, required this.groupsList});

  final List<Group> groupsList;

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    //this is a list of group objects
    List<Group> groupsList = widget.groupsList;

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
      ListView.builder
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
                  //function to view the corresponding group
                },
                child: GroupCard(groupItem: groupsList[index]),
              ),
            ),
            );
        }
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
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => const CreateGroup())));
            },
          ),
          FloatingActionButton.extended(
            // shape: const CircleBorder(),
            heroTag: null,
            mouseCursor: MaterialStateMouseCursor.textable,
            tooltip: "Add Group",
            label: const Text('Add Group'),
            icon: const Icon(Icons.group_add),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => const JoinGroup())));
            },
          ),
        ],
      ),
    );    
  }
}

