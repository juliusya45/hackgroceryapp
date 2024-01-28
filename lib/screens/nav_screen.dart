import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/group_related/groups_screen.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";


class Nav extends StatefulWidget{
  const Nav({super.key, required this.groupsList, required this.appUser});

  final List<Group> groupsList;
  final AppUser appUser;

  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int currentPageIndex = 0;
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  
  
// @override
//   Widget build(BuildContext context) {
//     final groupsList = widget.groupsList;
//     final appUser = widget.appUser;


//     final ThemeData theme = Theme.of(context);
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         indicatorColor: Colors.lightGreen,
//         selectedIndex: currentPageIndex,
//         destinations: const <Widget>[
//           NavigationDestination(
//             selectedIcon: Icon(Icons.group_sharp),
//             icon: Icon(Icons.group_outlined),
//             label: 'Groups',
//           ),
//           NavigationDestination(
//             icon: Badge(child: Icon(Icons.notifications_sharp)),
//             label: 'Notifications',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.logout_sharp),
//             label: 'Log Out',
//           ),
//         ],
//       ),
//       body: <Widget>[
//         /// Home page
//         GroupScreen(groupsList: groupsList, appUser: appUser,),

//         /// Notifications page
//         NotificationScreen(),

//         /// Settings page
//         SettingScreen()
//       ][currentPageIndex],
//     );
//   }

Widget build(BuildContext context) {
    final groupsList = widget.groupsList;
    final appUser = widget.appUser;
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          //borderRadius: BorderRadius.circular(10.0),
          
          colorBehindNavBar: Colors.grey,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
        return [
          GroupScreen(groupsList: widget.groupsList,appUser: widget.appUser,),
          NotificationScreen(),
          SettingScreen(),

        ];
    }

List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
           PersistentBottomNavBarItem(
              icon: Icon(Icons.groups),
              title: ("Groups"),
              activeColorPrimary: Colors.green,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.notifications),
              title: ("Notifications"),
              activeColorPrimary: Colors.green,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
            icon: Icon(Icons.logout),
            title: ("Logout"),
            activeColorPrimary: Colors.green,
              inactiveColorPrimary: Colors.grey,
            ),
        ];
    }   
}   
  