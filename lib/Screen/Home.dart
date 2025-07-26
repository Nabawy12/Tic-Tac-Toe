import 'package:flutter/material.dart';
import 'package:xogame/Screen/players.dart';

import 'BoardGame.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 270,
                  child: ElevatedButton.icon(
                    onPressed: (){
                      Navigator.pushNamed(
                          context,
                          Boardgame.routeName,
                          arguments: players("You", "Bot",true)
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        shadowColor: Colors.grey,
                    ),
                    icon: Icon(Icons.person_outline,size: 27,color: Colors.black,),
                    label:Text(
                      "Play Solo",
                      style: TextStyle(color: Colors.black,fontSize: 17),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: 270,
                  child: ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=> xoPlayer()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                    ),
                    icon: Icon(Icons.family_restroom_outlined,size: 27,color: Colors.black,),
                    label:                         Text(
                      "Play With a Friend",
                      style: TextStyle(color: Colors.black,fontSize: 17),
                    ),

                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
