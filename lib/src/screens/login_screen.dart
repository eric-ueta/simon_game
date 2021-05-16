import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simon_game/src/components/background.dart';
import 'package:simon_game/src/screens/game_screen.dart';
import 'package:simon_game/src/screens/home_screen.dart';
import 'package:simon_game/src/screens/signup_screen.dart';
import 'package:simon_game/src/services/login_service.dart';
import 'package:simon_game/src/utils/alert.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    color: Colors.white,
    fontSize: 20.0,
  );

  final nickController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    try {
      var nick = nickController.text;
      var password = passwordController.text;
      var response = await login(nick, password);

      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('id', response);
      prefs.setString('nick', nick);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
      );
    } on DioError catch (e) {
      showAlertDialog(context, "Usuário ou senha inválido");
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: nickController,
      obscureText: false,
      // style: TextStyle(color: Colors.white),
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
          20.0,
          15.0,
          20.0,
          15.0,
        ),
        hintText: "Nickname",
        hintStyle: style,
        counterStyle: style,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
          20.0,
          15.0,
          20.0,
          15.0,
        ),
        hintText: "Senha",
        hintStyle: style,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(
            color: Colors.white,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.purple,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(
          5.0,
          5.0,
          5.0,
          5.0,
        ),
        onPressed: signIn,
        child: Text(
          "Entrar",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.purple,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.fromLTRB(
          5.0,
          5.0,
          5.0,
          5.0,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SignUpScreen(),
            ),
          );
        },
        child: Text(
          "Cadastrar",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  "SIMON GAME",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
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
