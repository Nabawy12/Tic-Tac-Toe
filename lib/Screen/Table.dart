import 'package:flutter/material.dart';

class buttonPlay extends StatelessWidget {
   String text ;
   Function onClick ;
   int index ;
   buttonPlay({super.key, required this.text , required this.onClick, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onClick(index);
      },
      child: Container(
        height: 170,
        width: 135,
        margin: EdgeInsetsGeometry.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10)
        ),
        child:  Text(text,
          style: TextStyle(fontSize: 120,color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
