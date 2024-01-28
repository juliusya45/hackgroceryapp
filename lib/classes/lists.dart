import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack_grocery_app/classes/item.dart';


class Lists
{
  late String id;
  late String name;
  late String color;
  late List items;
  late String imgUrl;


  Lists({
    required this.id,
    required this.name,
    required this.color,
    required this.items,
    this.imgUrl = ""
    });

  //method to turn firestore data into a listing
  factory Lists.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,)
  {
    final data = snapshot.data();
    return Lists(
      id: '',
      name: data!['name'],
      color: data!['color'],
      items: data!['items'],
      imgUrl: data!['imgUrl']
    );
  }

  Map<String, dynamic> toFirestore()
  {
    return {
      'name': name,
      'color': color,
      'items': items,
      'imgUrl' : imgUrl
    };
  }

  addItem(String itemStr)
  {
    items.add(itemStr);
  }
}