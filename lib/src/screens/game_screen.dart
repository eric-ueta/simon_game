import 'package:flutter/material.dart';
import '../components/game_body.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: GameBody(),
      ),
      onWillPop: () async => false,
    );
  }
}
