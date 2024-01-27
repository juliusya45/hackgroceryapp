import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/screens/groups_screen.dart';
import 'package:hack_grocery_app/screens/main_setting_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';

class Nav extends StatefulWidget{
  const Nav({super.key,});
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int currentPageIndex = 0;
  
  
@override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        const GroupScreen(),

        /// Notifications page
        const NotificationScreen(),

        /// Settings page
        const SettingScreen()
      ][currentPageIndex],
    );
  }
}