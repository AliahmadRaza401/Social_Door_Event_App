import 'package:flutter/material.dart';


class CommomWidget{
  
  // Dialog alert
  showAlertDialog(BuildContext context, var error) {
    // setState(() {
    //   loading = false;
    // });
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Okay"),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> UserLogin()));
      },
    );
    // Widget continueButton = FlatButton(
    //   child: Text("Continue"),
    //   onPressed: () {
    //     // Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> UserRegistration(userMobile:mobileController.text)));
    //   },
    // );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Wrong Email Address"),
      content: Text(
        error,
        // style: TextStyle(fontSize: 18,fontFamily: Variable.fontStyle),
      ),
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
}
