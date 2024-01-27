import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/group.dart';
import 'package:hack_grocery_app/classes/user.dart';
import 'package:hack_grocery_app/screens/authentication/auth_page.dart';
import 'package:hack_grocery_app/screens/groups_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingHome extends StatefulWidget {
  const LoadingHome({super.key});

  @override
  State<LoadingHome> createState() => _LoadingHomeState();
}

class _LoadingHomeState extends State<LoadingHome> {
  //defining database
  final database = FirebaseFirestore.instance;
  List<Group> allGroups = [];
  late AppUser sendUser;

  Future<void> getUserData() async{
    final docName = FirebaseAuth.instance.currentUser?.uid;
    final userRef = database.collection('users').doc(docName).withConverter(
      fromFirestore: AppUser.fromFirestore, 
      toFirestore: (AppUser appuser, _) => appuser.toFirestore()
      );

    await userRef.get().then((value) {
      sendUser = value.data()!;
      print('got user!');
      //this prints out data from the db correctly
      print(sendUser.username);
    });
  }

  Future<void> setup() async{
    //defining the reference to our database:
    final ref = database.collection('groups').orderBy('time').withConverter(
    fromFirestore:  Group.fromFirestore,
    toFirestore: (Group groups, _) => groups.toFirestore(),
    );
    await getUserData();
    //once data populates from the database fill the list
    //of groups with groups that the user can access
    await ref.get().then((event)
    {
      for(var doc in event.docs)
      {
        final groups = doc.data();
        if(groups != null && sendUser.groups.contains(groups.id))
        {
            //giving the groups object an id since it was left out originally
            groups.id = doc.id;
            allGroups.add(groups);
        }
      }
    });
  }

  @override
  void initState()
  {
    super.initState();
    setup().then((result)
    {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if(sendUser != null)
        {
          Navigator.pushReplacement(context,
           MaterialPageRoute(
            settings: const RouteSettings(name: '/groups'),
            builder: (context) => GroupScreen()
            ),
           );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loading Home"),
      ),
      body: Center(
        child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
        LoadingAnimationWidget.prograssiveDots(
        color: Colors.black,
        size: 100),
          //this button is just for debugging, just in case we get stuck on this screen:
          ElevatedButton(
              child: Text("Sign Out"),
              
              onPressed:() {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                              //switch to Authpage?
                          return const AuthScreen();
                        },
                        transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        }),
                        (route) => false
                        );
              },
              ),
          
        ],
        
      ),
      ),
    );
  }
}