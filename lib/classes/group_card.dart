import 'package:flutter/material.dart';

import 'group.dart';

int hexToInteger(String hex) => int.parse(hex, radix: 16);
class GroupCard extends StatelessWidget{
  const GroupCard({
    super.key,
    required this.groupItem
  });

  final Group groupItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Color(hexToInteger(groupItem.color)),
      width: double.infinity,
      height: 100.0,
      alignment: Alignment.center,
      child: Text(
        groupItem.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),
       ),
    );
  }
}