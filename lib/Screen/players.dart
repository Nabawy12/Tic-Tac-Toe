import 'package:flutter/material.dart';
import 'package:xogame/Screen/BoardGame.dart';

class xoPlayer extends StatefulWidget {
  const xoPlayer({super.key,});

  @override
  State<xoPlayer> createState() => _xoPlayerPageState();
}

class _xoPlayerPageState extends State<xoPlayer> {
  String PlayerName1 = '' ;
  String PlayerName2 = '' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'XO Game Made With Flutter',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value){
                PlayerName1 = value ;
              },
              decoration: InputDecoration(
                label: Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
                    child: Text("Player 1")),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 27, vertical: 25),
              ),
            ),
            SizedBox(height: 25,),
            TextFormField(
              onChanged: (value){
                PlayerName2 = value ;
              },
              decoration: InputDecoration(
                label: Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
                    child: Text("Player 2")),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 27, vertical: 25),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(
                        context,
                        Boardgame.routeName,
                      arguments: players(PlayerName1, PlayerName2,false)
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.grey
                  ),
                  child: Text("Play Now",style: TextStyle(fontSize: 19,color: Colors.black),)
              ),
            )
          ],
        ),
      ),
    );
  }
}

class players {
  String playerName1 ;
  String playerName2 ;
  bool isAgainstBot;

  players(this.playerName1,this.playerName2, this.isAgainstBot);
}