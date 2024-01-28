import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/group_card.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/firebase_options.dart';
import 'package:hack_grocery_app/screens/authentication/login_screen.dart';
import 'package:hack_grocery_app/screens/authentication/signup_screen.dart';
import 'package:hack_grocery_app/screens/authentication/verification_screen.dart';
import 'package:hack_grocery_app/screens/group_setting_screen.dart';
import 'package:hack_grocery_app/screens/groups_screen.dart';
import 'package:hack_grocery_app/screens/loading_screens/initial_screen.dart';
import 'package:hack_grocery_app/screens/loading_screens/loading_home.dart';
import 'package:hack_grocery_app/screens/nav_screen.dart';
import 'package:hack_grocery_app/screens/logout_screen.dart';
import 'package:hack_grocery_app/screens/notification_screen.dart';
import 'package:hack_grocery_app/screens/individual_group_screen.dart';
import 'package:hack_grocery_app/classes/lists.dart';
import 'package:hack_grocery_app/classes/list_card.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    //objects that hold empty data:
    var emptyGroup = Group(color: 'ff32a852', id: '', name: 'Tests', imgUrl: '', lists: []);
    var emptyUser = AppUser(uid: '', username: '', email: '', groups: []);

    //different groups to test out:
    var group1 = Group(color: 'ff95b1de', id: '', name: 'Test2', imgUrl: '', lists: []);
    var group2 = Group(color: 'ff95b25a', id: '', name: 'Test3', imgUrl: '', lists: []);
    var group3 = Group(color: 'ff9502bc', id: '', name: 'Test4', imgUrl: '', lists: []);

    //List<Group> groupsList = [emptyGroup, group1, group2, group3];
    List<Group> groupsList = [];

    var list1 = Lists(color:'ff95b1de', id: '', name: 'Test1', imgUrl: '', items: []);
    var list2 = Lists(color:'ff1531ae', id: '', name: 'Test2', imgUrl: '', items: []);
    var list3 = Lists(color:'ff51c11e', id: '', name: 'Test3', imgUrl: '', items: []);
    List<Lists> listsList = [list1, list2, list3];

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Inter',useMaterial3: true),
      initialRoute: '/group_setting_screen',
      routes: {
        //now goes to initialscreen and this checks to see if a user was logged in or not
        '/': (context) => InitialScreen(groupsList: groupsList, appUser: emptyUser,),
        '/nav': (context) => Nav(groupsList: groupsList, appUser: emptyUser,),
        '/verification': (context) => VerificationScreen(),
        '/group_screen': (context) => GroupScreen(groupsList: groupsList, appUser: emptyUser,),
        '/loading_home': (context) => LoadingHome(),
        '/group_card': (context) => GroupCard(groupItem: emptyGroup),
        '/list_screen': (context) => IndividualGroupScreen(listsList: listsList,),
        '/group_setting_screen': (context) => GroupSettingScreen(),
      },
    );
  }
}
