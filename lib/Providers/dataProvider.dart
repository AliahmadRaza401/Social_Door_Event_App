import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_door/Utils/authException.dart';

class DataProvider extends ChangeNotifier {
  var token;
  var error;
  bool loading = false;

  // saveError(error) {
  //   error = error;
  // }

  // Login
  Future<void> Login(String email, String password) async {
    loading = true;
    try {
      print("---------------Login------------------------------");
      print(email);
      print(password);
      final url =
          Uri.parse('https://socialeventdoor.herokuapp.com/api/user/login');

      final responce = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      final responceData = json.decode(responce.body);
      print("---------------Login Result-----------------------------");
      debugPrint(responceData.toString());
      error = responceData['email'];

      if (responceData["success"] == true) {
        print("Suceess Login");
        debugPrint(responce.toString());
        debugPrint('erroe ${responceData['email']}');
      } else {
        print("UnSuceess Login");
        debugPrint('error ${responceData['email']}');
        // setState(() {
        //   error = responceData['email'];
        // });

      }

      notifyListeners();
    } on AuthException catch (e) {
      debugPrint('exception ${e.toString()}');
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            width: 30,
          ),
          Container(
              margin: EdgeInsets.only(left: 3),
              child: Text("Logging.. Please wait...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => alert,
    );
  }

  // login alert
  showAlertDialog(BuildContext context, error) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> UserLogin()));
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        // Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> UserRegistration(userMobile:mobileController.text)));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("hy"), //Text("${resp['msg']}"),
      content: Text(
        "Please Register to continue!",
        // style: TextStyle(fontSize: 18,fontFamily: Variable.fontStyle),
      ),
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

  // Sign Up
  Future<void> SignUp(
      String fName,
      String lName,
      String dob,
      String gender,
      String email,
      String password,
      String phone,
      String password_confirm) async {
    try {
      print("---------------  Sign Up-----------------------------");
      final url =
          Uri.parse('https://socialeventdoor.herokuapp.com/api/user/register');

      final responce = await http.post(url, body: {
        'first_name': fName,
        'last_name': lName,
        'dob': dob,
        'gender': gender,
        'email': email,
        'password': password,
        'phone': phone,
        'password_confirm': password_confirm
      });

      final responceData = json.decode(responce.body);
      print("---------------  Sign Up  Data-----------------------------");
      print(responceData);
      notifyListeners();
    } catch (e) {}
  }
}
