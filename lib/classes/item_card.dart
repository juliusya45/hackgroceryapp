import 'package:flutter/material.dart';

import 'item.dart';

class ItemCard extends StatelessWidget{
  ItemCard({
    super.key,
    required this.itemInst,
  });
  bool checkVal = false;
  late ValueChanged<bool> onChanged;
  final Item itemInst;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!checkVal);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        height: 70.0,
        child: Row(
          children: <Widget>[
            Checkbox(value: checkVal, 
            onChanged: (bool? newValue){
              onChanged(newValue!);
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