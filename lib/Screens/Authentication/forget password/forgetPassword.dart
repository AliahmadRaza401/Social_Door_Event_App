import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:social_door/Screens/Authentication/forget%20password/verifyNumber.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  var email;
  var error;
  bool loading = false;

  submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });

      try {
        resetPassword();
      } catch (e) {
        print(e);
      }
    }
  }

  resetPassword() async {
    final response = await http.post(
      Uri.parse('https://socialeventdoor.herokuapp.com/api/user/recover'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);

    //display Error
    if (data['success'] != true) {
      setState(() {
        error = data['message'];
      });
      showAlertDialog(context, error);
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => VerifyPhonenumber()));
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xff1A1A36),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Image.asset(
                              "assets/png/logoc.png",
                              width: 100,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [Text("           ")],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 90, bottom: 60),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: [
                        Text(
                          "Forget Password",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Enter the Email address associated with",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          " your account",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage(
                          'assets/png/mobile.png',
                        ),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          inputField("Enter Email", Icon(Icons.call)),
                          Container(
                            height: 60,
                            margin: EdgeInsets.only(bottom: 10),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: FlatButton(
                              child: loading == true
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Reset password",
                                      style: TextStyle(fontSize: 18),
                                    ),
                              onPressed: () {
                                submit();
                              },
                              color: Color(0xffFF5018),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget inputField(String name, icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffDCDCE0),
      ),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        validator: MultiValidator([
          EmailValidator(errorText: "enter a valid email address"),
          RequiredValidator(errorText: "Required")
        ]),
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          hintText: name,
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 1),
            child: icon,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xffff5018), width: 3),
          ),
        ),
      ),
    );
  }

  // login alert
  showAlertDialog(BuildContext context, var error) {
    setState(() {
      loading = false;
    });
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
