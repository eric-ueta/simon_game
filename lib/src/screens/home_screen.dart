import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simon_game/src/components/background.dart';
import 'package:simon_game/src/screens/profile_screen.dart';
import 'package:simon_game/src/screens/ranking_screen.dart';
import 'package:simon_game/src/services/login_service.dart';

import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    color: Colors.white,
    fontSize: 20.0,
  );

  @override
  void initState() {
    super.initState();
    first();
  }

  void first() async {
    final prefs = await SharedPreferences.getInstance();
    int record = 0;
    try {
      record = await getRecord(prefs.getInt('id'));
      prefs.setInt('record', record);
    } catch (e) {}
  }

  void startGame() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => GameScreen(),
      ),
    );
  }

  void seeProfile() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ProfileScreen(),
      ),
    );
  }

  void seeRanking() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => RankingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final playButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.orange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.fromLTRB(
          5.0,
          5.0,
          5.0,
          5.0,
        ),
        onPressed: startGame,
        child: Text(
          "Jogar",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final rankingButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.pink,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.fromLTRB(
          5.0,
          5.0,
          5.0,
          5.0,
        ),
        onPressed: seeRanking,
        child: Text(
          "Ranking",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final profileButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.fromLTRB(
          5.0,
          5.0,
          5.0,
          5.0,
        ),
        onPressed: seeProfile,
        child: Text(
          "Perfil",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Container(
          decoration: Background,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SIMON GAME",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: new EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        rankingButton,
                        SizedBox(height: 50),
                        profileButton,
                        SizedBox(height: 50),
                        playButton,
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
