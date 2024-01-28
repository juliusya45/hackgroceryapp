import 'package:flutter/material.dart';

import 'lists.dart';

int hexToInteger(String hex) => int.parse(hex, radix: 16);
class ListCard extends StatelessWidget{
  const ListCard({
    super.key,
    required this.listItem
  });

  final Lists listItem;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(

        borderRadius: BorderRadius.circular(20.0),
        child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Color(hexToInteger('ff49ad6a')),
            width: 200,
            height: 100,
            alignment: Alignment.center,
            child: Text(
                  listItem.name,
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