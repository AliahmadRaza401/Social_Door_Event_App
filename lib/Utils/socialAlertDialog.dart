
import 'package:flutter/material.dart';

socialAlertDialog(BuildContext context, goto) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => goto));
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Login Failed!"),
    content: Text("Please click continue to SignUp firstly"),
    actions: [
      cancelButton,
      continueButton,
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
