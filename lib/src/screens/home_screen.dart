import 'package:flutter/material.dart';
import '../components/game_body.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Simon Game"),
      //   centerTitle: true,
      //   // actions: [
      //   //   Row(
      //   //     children: [
      //   //       Center(
      //   //         child: Icon(
      //   //           Icons.emoji_events_outlined,
      //   //           color: Colors.yellow,
      //   //         ),
      //   //       ),
      //   //       Center(
      //   //         child: Text("Acertos:"),
      //   //       ),
      //   //       Center(
      //   //         child: Text(
      //   //           sequence.toString(),
      //   //         ),
      //   //       )
      //   //     ],
      //   //   )
      //   // ],
      // ),
      // backgroundColor: Colors.transparent,
      body: GameBody(),
    );
  }
}
