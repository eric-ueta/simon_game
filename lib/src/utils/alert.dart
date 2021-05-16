import 'package:flutter/material.dart';
import 'package:simon_game/src/screens/home_screen.dart';

showAlertDialog(BuildContext context, String message) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true)
          .pop(); // dismisses only the dialog and returns nothing
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Atenção"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

gameOverAlert(BuildContext context, String message) {
  // set up the button
  Widget homeButton = FlatButton(
    child: Text("Voltar ao Menu"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
      );
    },
  );

  Widget continueButton = FlatButton(
    child: Text("Continuar"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true)
          .pop(); // dismisses only the dialog and returns nothing
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Atenção"),
    content: Text(message),
    actions: [continueButton, homeButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
