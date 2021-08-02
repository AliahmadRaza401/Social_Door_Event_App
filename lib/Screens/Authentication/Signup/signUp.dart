import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Screens/Authentication/Login/login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool agree = false;
  bool _isObscure = true;
  var token;
  var error;
  var data;
  bool loading = false;
  void _doSomething() {}

  var first_name;
  var last_name;
  var dob;
  var gender;
  var email;
  var password;
  var phone;
  var password_confirm;

  final _formKey = GlobalKey<FormState>();

  void submit() {
    if (_formKey.currentState!.validate()) {
      print("Validate");
      setState(() {
        loading = true;
      });

      signUp();
    } else {
      _formKey.currentState!.save();
      // _formKey.currentState.save();

    }
  }

  signUp() async {
    print("-------------------- Sign Up ---------------");
    try {
      final response = await http.post(
        Uri.parse(Api().register),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'first_name': first_name,
          'last_name': last_name,
          'dob': dob,
          'gender': gender,
          'email': email,
          'password': password,
          'phone': phone,
          'password_confirm': password_confirm
        }),
      );
      data = jsonDecode(response.body);
      print(data);
      if (data['success'] == true) {
        debugPrint('SignIn success');
        setState(() {
          token = data['token'];
          error = "SignIn Successfully";
        });
        showAlertDialog(context, error);
      } else if (data['name'] != null) {
        debugPrint('name ${data['name']}');
        setState(() {
          error = '${data['name']}';
        });
        showAlertDialog(context, error);
      } else if (data['phone'] != null) {
        debugPrint('phone ${data['phone']}');
        setState(() {
          error = '${data['phone']}';
        });
        showAlertDialog(context, error);
      } else if (data['email'] != null) {
        debugPrint('phone ${data['email']}');
        setState(() {
          error = '${data['email']}';
        });
        showAlertDialog(context, error);
      } else if (data['password_confirm'] != null) {
        debugPrint('phone ${data['password_confirm']}');
        setState(() {
          error = '${data['password_confirm']}';
        });
        showAlertDialog(context, error);
      } else {
        debugPrint('email ${data['email']}');
        setState(() {
          error = 'Something went Wrong';
        });
        showAlertDialog(context, error);
      }
    } catch (e) {
      showAlertDialog(context, "Something went wrong! Please try again");
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
                            width: 80,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [Text("           ")],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SignUp",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    height: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        // colorFilter: new ColorFilter.mode(Colors.grey.withOpacity(1), BlendMode.dstATop),
                        image: new AssetImage(
                          'assets/png/signup0.png',
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            fNameField(),
                            lNameField(),
                            emailField(),
                            phoneField(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    genderField(),
                                  ],
                                ),
                                Column(
                                  children: [
                                    dobField(),
                                  ],
                                ),
                              ],
                            ),
                            passwordField(),
                            confirmPasswordField(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  activeColor: Color(0xffff5018),
                                  value: agree,
                                  onChanged: (value) {
                                    setState(() {
                                      agree = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'I have read and accept terms and conditions',
                                  style: TextStyle(color: Colors.white60),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
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
                                        "Sign Up",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                onPressed: () {
                                  submit();
                                },
                                // onPressed: agree ? _doSomething : null,
                                color: Color(0xffFF5018),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Contact With",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  margin: EdgeInsets.only(
                                    right: 20,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color(0xff80808E),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: SvgPicture.asset(
                                    "assets/svg/fb.svg",
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color(0xff80808E),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: SvgPicture.asset(
                                    "assets/svg/google.svg",
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Already have an Account?   ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  child: Text(
                                    "SignIn",
                                    style: TextStyle(
                                        color: Color(0xffFF5018),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
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
        ),
      ),
    );
  }

  Widget fNameField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffDCDCE0),
      ),
      child: TextFormField(
        onChanged: (value) {
          first_name = value;
        },
        validator: RequiredValidator(errorText: "Required"),
        cursorColor: Color(0xffff5018),
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          hintText: "First Name",
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Icon(Icons.person, color: Color(0xffff5018)),
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

  Widget lNameField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffDCDCE0),
      ),
      child: TextFormField(
        onChanged: (value) {
          last_name = value;
        },
        validator: RequiredValidator(errorText: "Required"),
        cursorColor: Color(0xffff5018),
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          hintText: "Last Name",
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Icon(Icons.person, color: Color(0xffff5018)),
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

  Widget emailField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffDCDCE0),
      ),
      child: TextFormField(
        onChanged: (value) {
          email = value;
        },
        validator: MultiValidator([
          RequiredValidator(errorText: "Required"),
          EmailValidator(errorText: "Enter valid Email"),
        ]),
        cursorColor: Color(0xffff5018),
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          hintText: "Email",
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Icon(Icons.mail, color: Color(0xffff5018)),
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

  Widget phoneField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffDCDCE0),
      ),
      child: TextFormField(
        onChanged: (value) {
          phone = value;
        },
        validator: RequiredValidator(errorText: "Required"),
        cursorColor: Color(0xffff5018),
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          hintText: "Phone Number",
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Icon(Icons.phone, color: Color(0xffff5018)),
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

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  //  String password;

  // hide/show Password Input Firld
  Widget passwordField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffDCDCE0),
      ),
      child: TextFormField(
        onChanged: (value) {
          password = value;
        },
        // onChanged: (val) => password = val,
        validator: passwordValidator,
        obscureText: _isObscure,
        cursorColor: Color(0xffff5018),
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          hintText: "Password",
          suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              }),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Icon(Icons.lock, color: Color(0xffff5018)),
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

  Widget confirmPasswordField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffDCDCE0),
      ),
      child: TextFormField(
        onChanged: (value) {
          password_confirm = value;
        },
        // validator: (val) => MatchValidator(errorText: 'passwords do not match')
        //     .validateMatch(val!, password),
        obscureText: _isObscure,
        cursorColor: Color(0xffff5018),
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          hintText: "Confirm password",
          suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              }),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Icon(Icons.lock, color: Color(0xffff5018)),
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

  Widget genderField() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffDCDCE0),
      ),
      child: TextFormField(
        onChanged: (value) {
          gender = value;
        },
        validator: RequiredValidator(errorText: "Required"),
        cursorColor: Color(0xffff5018),
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          hintText: "Gender",
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Icon(
              Icons.person,
              color: Color(0xffff5018),
            ),
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

  Widget dobField() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffDCDCE0),
      ),
      child: TextFormField(
        onChanged: (value) {
          dob = value;
        },
        validator: RequiredValidator(errorText: "Required"),
        cursorColor: Color(0xffff5018),
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xffff5018), width: 3),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          errorStyle: TextStyle(
            fontSize: 15.0,
          ),
          fillColor: Colors.red,
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(12.0),
            ),
          ),
          hintText: 'DOB',
          prefixIcon: Icon(
            Icons.email_rounded,
            color: Color(0xffff5018),
          ),
        ),
      ),
    );
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
  showAlertDialog(BuildContext context, var error) {
    setState(() {
      loading = false;
    });
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Okay"),
      onPressed: () {
        if (data['success'] == true) {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => Login()));
        } else {
          Navigator.pop(context);
        }
      },
    );
    // Widget continueButton = FlatButton(
    //   child: Text("Continue"),
    //   onPressed: () {
    //   },
    // );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(error),
      content: Text(
        "Please Enter correct data to continue!",
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
