import 'package:flutter/material.dart';
import '../components/game_body.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
