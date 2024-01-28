import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack_grocery_app/classes/lists.dart';


class Group
{
  late String id;
  late String name;
  late String color;
  late List lists;
  late String imgUrl;


  Group({
    required this.id,
    required this.name,
    required this.color,
    required this.lists,
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
      lists: data!['lists'],
      imgUrl: data!['imgUrl']
    );
  }

  Map<String, dynamic> toFirestore()
  {
    return {
      'name': name,
      'color': color,
      'lists': lists,
      'imgUrl' : imgUrl
    };
  }

  addList(String listStr)
  {
    lists.add(listStr);
  }

  removeList(String listStr)
  {
    if(lists.contains(listStr))
    {
      lists.remove(listStr);
    }
    else
      return "List ID not found";
  }
}