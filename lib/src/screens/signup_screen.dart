import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simon_game/src/components/background.dart';
import 'package:simon_game/src/services/login_service.dart';
import 'package:simon_game/src/utils/alert.dart';

class errorResponse {
  String error;
}

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    color: Colors.white,
    fontSize: 20.0,
  );

  final nickController = TextEditingController();
  final passwordController = TextEditingController();

  void signUp() async {
    try {
      var nick = nickController.text;
      var password = passwordController.text;
      await createUser(nick, password);
    } on DioError catch (e) {
      showAlertDialog(context, "Usuário já existente, escolha outro");
    }
  }

  @override
  Widget build(BuildContext context) {
    final nickField = TextField(
      controller: nickController,
      obscureText: false,
      // style: TextStyle(color: Colors.white),
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nickname",
          hintStyle: style,
          counterStyle: style,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Senha",
          hintStyle: style,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.purple,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        onPressed: signUp,
        child: Text("Cadastrar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          decoration: Background,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Cadastre-se",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 45.0),
                nickField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                signUpButton,
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
