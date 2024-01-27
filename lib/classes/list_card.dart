import 'package:flutter/material.dart';

import 'lists.dart';

int hexToInteger(String hex) => int.parse(hex, radix: 16);
class ListCard extends StatelessWidget{
  const ListCard({
    super.key,
    required this.listItem
  });

  final List listItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Color(hexToInteger(listItem.color)),
      width: double.infinity,
      height: 100.0,
      alignment: Alignment.center,
      child: Text(
        listItem.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),
       ),
    );
  }
}