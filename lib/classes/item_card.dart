import 'package:flutter/material.dart';

import 'item.dart';

class ItemCard extends StatefulWidget{
  const ItemCard({
    super.key,
    required this.itemInst,
  });
  final Item itemInst;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool checkVal = false;

  @override
  Widget build(BuildContext context) {
    final Item itemInst = widget.itemInst;
    return InkWell(
      onTap: () {
        //Bring up description
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        height: 70.0,
        child: Row(
          children: <Widget>[
            Checkbox(value: checkVal, 
            onChanged: (bool? newValue){
              setState(() {
                checkVal = newValue!;
              });
            },),
            Expanded(child: Text(
              itemInst.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              )
            ))
          ]
          )
      )
    );
  }
}