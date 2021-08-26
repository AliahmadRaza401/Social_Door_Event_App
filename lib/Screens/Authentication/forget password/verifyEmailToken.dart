import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Screens/Authentication/Update%20Password/updatePassword.dart';

class VerifyPhonenumber extends StatefulWidget {
  @override
  _VerifyPhonenumberState createState() => _VerifyPhonenumberState();
}

class _VerifyPhonenumberState extends State<VerifyPhonenumber> {
  TextEditingController textEditingController = TextEditingController();

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  var error;
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  tokenConfirm() async {
    loading = true;
    final response = await http.get(
      Uri.parse(Api().codeConfirmation(currentText)
          // 'https://socialeventdoor.herokuapp.com/api/user/reset/$currentText'
          ),
    );
    var data = jsonDecode(response.body);
    print(data);

    //display Error
    if (data['success'] != true) {
      print("Wrong.....................:");
      setState(() {
        error = data['message'];
      });
      showAlertDialog(context, error);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UpdatePassword(
                verifyToken: currentText,
              )));
      setState(() {
        snackBar("OTP Verified!!");
        loading = false;
      });
    }
  }

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
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
                          "Verify your account",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please enter the 6 digit code send to",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          "your mail",
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
                        // colorFilter: new ColorFilter.mode(Colors.grey.withOpacity(1), BlendMode.dstATop),
                        image: new AssetImage(
                          'assets/png/mobile.png',
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        otpField(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            hasError
                                ? "*Please fill up all the cells properly"
                                : "",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
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
                                    "Confirm",
                                    style: TextStyle(fontSize: 18),
                                  ),
                            onPressed: () {
                              formKey.currentState!.validate();
                              // conditions for validating
                              if (currentText.length != 6) {
                                errorController.add(ErrorAnimationType
                                    .shake); // Triggering error shake animation
                                setState(() {
                                  hasError = true;
                                });
                              } else {
                                setState(
                                  () {
                                    hasError = false;
                                  },
                                );
                                tokenConfirm();
                              }
                            },
                            color: Color(0xffFF5018),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive the code? ",
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 15),
                            ),
                            TextButton(
                                onPressed: () => snackBar("OTP resend!!"),
                                child: Text(
                                  "RESEND",
                                  style: TextStyle(
                                      color: Color(0xffff5018),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ))
                          ],
                        ),
                      ],
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

  Widget otpField() {
    return Form(
      key: formKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
          child: PinCodeTextField(
            appContext: context,
            pastedTextStyle: TextStyle(
              color: Color(0xffFF5018),
              fontWeight: FontWeight.bold,
            ),
            length: 6,
            // obscureText: true,
            obscuringCharacter: '*',
            // obscuringWidget: FlutterLogo(
            //   size: 24,
            // ),
            blinkWhenObscuring: true,
            animationType: AnimationType.fade,
            validator: (v) {
              if (v!.length < 5) {
                return "I'm from validator";
              } else {
                return null;
              }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: hasError ? Colors.blue.shade100 : Colors.white,
            ),
            cursorColor: Color(0xffFF5018),
            animationDuration: Duration(milliseconds: 300),
            enableActiveFill: true,
            errorAnimationController: errorController,
            controller: textEditingController,
            keyboardType: TextInputType.number,
            boxShadows: [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
            onCompleted: (v) {
              print("Completed");
            },
            // onTap: () {
            //   print("Pressed");
            // },
            onChanged: (value) {
              print(value);
              setState(() {
                currentText = value;
                print(currentText);
              });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          )),
    );
  }

  // Dialog alert
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
      title: Text("Please Try Again"),
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
