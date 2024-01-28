import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/groups_screen.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';

class Nav extends StatefulWidget{
  const Nav({super.key, required this.groupsList, required this.appUser});

  final List<Group> groupsList;
  final AppUser appUser;

  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int currentPageIndex = 0;
  
  
@override
  Widget build(BuildContext context) {
    final groupsList = widget.groupsList;
    final appUser = widget.appUser;


    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.lightGreen,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.group_sharp),
            icon: Icon(Icons.group_outlined),
            label: 'Groups',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(Icons.logout_sharp),
            label: 'Log Out',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        GroupScreen(groupsList: groupsList, appUser: appUser,),

        /// Notifications page
        NotificationScreen(),

        /// Settings page
        SettingScreen()
      ][currentPageIndex],
    );
  }
}