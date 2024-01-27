import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  late String uid;
  late String username;
  late String email;
  late List groups;

  AppUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.groups
  });

  factory AppUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,)
  {
    final data = snapshot.data();
    //the uid is left empty since it needs be fetched from user object
    return AppUser(
      uid: '',
      username: data?['username'],
      email: data?['email'],
      groups: data?['groups']
      );
  }

  Map<String, dynamic> toFirestore()
  {
    return {
      'email' : email,
      'username' : username,
      'groups' : groups
    };
  }

}