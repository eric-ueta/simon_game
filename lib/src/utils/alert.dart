import 'package:flutter/material.dart';

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
