import 'package:flutter/material.dart';

import 'item.dart';

class ItemCard extends StatelessWidget{
  const ItemCard({
    super.key,
    required this.itemInst
  });

  final Item itemInst;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      height: 100.0,
      alignment: Alignment.center,
      child: Text(
        itemInst.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),
       ),
    );
  }
}