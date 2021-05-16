import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simon_game/src/components/background.dart';
import 'package:simon_game/src/screens/profile_screen.dart';
import 'package:simon_game/src/services/login_service.dart';

import 'game_screen.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  List<dynamic> users = [];

  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    color: Colors.white,
    fontSize: 20.0,
  );

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

  first() async {
    try {
      var response = await getUser();
      print(response);

      setState(() {
        users = response;
      });

      //users.sort((a, b) => a['record'] > b['record'] ? 0 : 1);
    } on DioError catch (e) {
      //showAlertDialog(context, "Usuário ou senha inválido");
    }
  }

  @override
  void initState() {
    super.initState();
    first();
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: () => print('pressed'),
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking'),
      ),
      body: Container(
        decoration: Background,
        child: Center(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext ctxt, int index) {
              switch (users[index]['nick']) {
                case '':
                case 'null':
                case 'undefined':
                default:
                  return new ListTile(
                    tileColor: Colors.white60,
                    leading: Icon(
                      Icons.emoji_events,
                      color: Colors.yellow,
                    ),
                    title: Text(
                      users[index]['record'].toString() +
                          '      ' +
                          users[index]['nick'],
                      style: TextStyle(
                        color: Colors.yellow,
                      ),
                    ),
                  );
              }
            },
          ),
        ),
        // child: ListView(
        //   children: <Widget>[
        //     ListTile(
        //       leading: Icon(Icons.map),
        //       title: Text('Map'),
        //     ),
        //     ListTile(
        //       leading: Icon(Icons.photo_album),
        //       title: Text('Album'),
        //     ),
        //     ListTile(
        //       leading: Icon(Icons.phone),
        //       title: Text('Phone'),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
