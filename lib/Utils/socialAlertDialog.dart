import 'package:flutter/material.dart';

alertDialog(BuildContext context, title, subtitle) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Okay"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Widget continueButton = FlatButton(
  //   child: Text("Okay"),
  //   onPressed: () {
  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => goto));
  //   },
  // );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(subtitle),
    actions: [
      cancelButton,
      // continueButton,
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

socialAlertDialog(
  BuildContext context,
  title,
  description,
  goto,
) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("cancel"),
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
    title: Text(title),
    content: Text(description),
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
