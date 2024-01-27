import 'package:cloud_firestore/cloud_firestore.dart';

class Item{
  late String id;
  late String name;
  late String description;
  late String imgUrl;

  Item({
    required this.id,
    required this.name,
    required this.description,
    this.imgUrl = ""
  });

  //method to turn firestore data into a listing
  factory Item.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,)
  {
    final data = snapshot.data();
    return Item(
      id: '',
      name: data!['name'],
      description: data!['description'],
      imgUrl: data!['imgUrl']
    );
  }

  Map<String, dynamic> toFirestore()
  {
    return {
      'name': name,
      'description': description,
      'imgUrl' : imgUrl
    };
  }
}