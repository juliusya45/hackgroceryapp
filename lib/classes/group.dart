import 'package:cloud_firestore/cloud_firestore.dart';

class Group
{
  late String id;
  late String name;
  late String color;
  late String imgUrl;


  Group({
    required this.id,
    required this.name,
    required this.color,
    this.imgUrl = ""
  });


//method to turn firestore data into a listing
  factory Group.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,)
  {
    final data = snapshot.data();
    return Group(
      id: '',
      name: data!['name'],
      color: data!['color'],
      imgUrl: data!['imgUrl']
    );
  }

  Map<String, dynamic> toFirestore()
  {
    return {
      'name': name,
      'color': color,
      'imgUrl' : imgUrl
    };
  }
}