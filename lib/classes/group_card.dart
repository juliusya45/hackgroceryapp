import 'package:flutter/material.dart';
import 'package:hack_grocery_app/classes/lists.dart';

import 'group.dart';


class GroupCard extends StatelessWidget{
  const GroupCard({
    super.key,
    required this.groupItem
  });
  int hexToInteger(String hex) => int.parse(groupItem.color, radix: 16);

  final Group groupItem;

  @override
  Widget build(BuildContext context) {
    //for now this will be used to show it on a blank page
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Color(hexToInteger(groupItem.color)),
            width: 200,
            height: 100,
            alignment: Alignment.center,
            child: Text(
                  groupItem.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
              ),
            ),
      );
  }
}