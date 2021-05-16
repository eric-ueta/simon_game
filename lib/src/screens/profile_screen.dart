import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simon_game/src/components/background.dart';

import 'camera_screen.dart';

class ProfileScreen extends StatefulWidget {
  String imgPath = '';
  TakePictureScreen cameraController;

  ProfileScreen({this.imgPath});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int record = 0;
  String nick = '';
  String previusImg = '';

  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    color: Colors.white,
    fontSize: 20.0,
  );

  @override
  void initState() {
    first();
    super.initState();
  }

  first() async {
    final prefs = await SharedPreferences.getInstance();
    final record = prefs.getInt('record') ?? 0;
    final nick = prefs.getString('nick') ?? '';
    final previusImg = prefs.getString('img') ?? '';

    setState(() {
      this.record = record;
      this.nick = nick;
      this.previusImg = previusImg;
    });
  }

  void takePicture() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => TakePictureScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editButton = Material(
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
        onPressed: takePicture,
        child: Text(
          "Editar Foto",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        decoration: Background,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "PERFIL",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      previusImg != ''
                          ? Image.file(
                              File(previusImg),
                              height: 90,
                              width: 90,
                            )
                          : CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/140x100'),
                            ),
                      // CircleAvatar(
                      //   radius: 40,
                      //   backgroundImage: widget.imgPath == ''
                      //       ? NetworkImage(
                      //           'https://via.placeholder.com/140x100')
                      //       : Image.file(File(widget.imgPath)),
                      // ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Align(
                            child: Text(
                              'Nome:',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            child: Text(
                              'Record:',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '$nick',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$record',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                editButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}
