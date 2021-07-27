import 'dart:convert';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Api/google__api.dart';
import 'package:social_door/Api/social_login.dart';
import 'package:social_door/Screens/Authentication/Signup/signUp.dart';
import 'package:social_door/Screens/Authentication/forget%20password/forgetPassword.dart';
import 'package:social_door/Screens/Home/home.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:social_door/Utils/loader.dart';
import 'package:social_door/Utils/socialAlertDialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email;
  var password;
  var error;
  bool loading = false;
  bool _socialLoading = false;
  final _formKey = GlobalKey<FormState>();
  var token;
  var _userObj;

  @override
  void initState() {
    super.initState();
    check_already_LogIn();
  }

  check_already_LogIn() async {
    final userData = await SharedPreferences.getInstance();
    bool newUser = (userData.getBool('userLogin') ?? false);

    print("New User_______: ${newUser}");
    if (newUser == true) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    }
  }

  userLoginTrue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLogin', true);
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {}
    _formKey.currentState!.save();
    setState(() {
      loading = true;
    });
    try {
      login();
    } catch (e) {
      showAlertDialog(context, "Try again");
    }
  }

  login() async {
    final response = await http.post(
      Uri.parse(Api().login),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email, "password": password}),
    );
    var data = jsonDecode(response.body);
    print(data);
    if (data['success'] == true) {
      debugPrint('login success');
      setState(() {
        token = data['token'];
        error = "Login Successfully";
        loading = false;
      });
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
      userLoginTrue();
    } else {
      if (data['password'] != null) {
        debugPrint('passwrod ${data['password']}');
        setState(() {
          error = '${data['password']}';
        });
        showAlertDialog(context, error);
      } else {
        debugPrint('email ${data['email']}');
        setState(() {
          error = '${data['email']}';
        });
        showAlertDialog(context, error);
      }
    }
  }

//Goole Sigin
  Future googleSignIn() async {
    print("Google SignIn---------------------");
    final user = await GoogleApi.login();
    setState(() {
      _socialLoading = true;
    });
    //Fetch Data
    final names = user!.displayName!.split(' ');
    final firstName = names[0];
    final lastName = names.length > 1 ? names[1] : '';
    print(user);
    print(firstName);
    print(lastName);
    print(user.email);
    print(user.photoUrl);

    try {
      var result = await SocialLogin().loginWithFacebook(
        firstName,
        lastName,
        user.email,
        user.photoUrl,
        user.id,
      );

      if (result['emailSuccess'] == true) {
        print("Login Success");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
        userLoginTrue();
        setState(() {
          _socialLoading = false;
        });
      } else {
        print("Login UnSuccess");
        socialAlertDialog(context, SignUp());
        setState(() {
          _socialLoading = false;
        });
      }
    } catch (e) {
      print("Error");
      showAlertDialog(context, e);
      _socialLoading = false;
    }

    // if (user == null) {
    //   showAlertDialog(context, "SignIn Failed");
    // } else {
    //   userLoginTrue();
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => Home()));
    // }
  }

// Fb SignIn
  Future fbSignIn() async {
    print("Fb SignIn---------------------");
    final user = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) async {
      FacebookAuth.instance.getUserData().then((userData) {
        setState(() {
          _userObj = userData;
          _socialLoading = true;
        });
        userLoginTrue();
        var decodeData = _userObj.toString();
      });

      // Fetch Data
      var token = value.accessToken!.token;
      var graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));

      var profile = json.decode(graphResponse.body);
      print("--------------------------");
      print(profile.toString());

      var result = await SocialLogin().loginWithFacebook(
        profile['first_name'],
        profile['last_name'],
        profile['email'],
        _userObj['picture']['data']['url'],
        profile['id'],
      );
      print(result);

      if (result['success'] == true && result['emailSuccess'] == true) {
        print("Login Success");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
        userLoginTrue();
        setState(() {
          _socialLoading = false;
        });
      } else {
        print("Login UnSuccess");
        socialAlertDialog(context, SignUp());
        setState(() {
          _socialLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xff1A1A36),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Image.asset(
                            "assets/png/logoc.png",
                            width: 110,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Signin",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // errorMsg == null
                            //     ? CircularProgressIndicator()
                            //     : Text(errorMsg),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: EdgeInsets.only(bottom: 10),
                              height: 330,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  // colorFilter: new ColorFilter.mode(Colors.grey.withOpacity(1), BlendMode.dstATop),
                                  image: new AssetImage(
                                    'assets/png/sigin0.png',
                                  ),
                                ),
                              ),
                              child: Form(
                                key: _formKey,
                                autovalidate: true,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      emailField(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      passwordField(),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 60,
                                        margin: EdgeInsets.only(bottom: 10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: FlatButton(
                                          child: loading == true
                                              ? CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : Text(
                                                  "Sign In",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                          onPressed: () {
                                            submit();
                                          },
                                          color: Color(0xffFF5018),
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgetPassword()));
                                        },
                                        child: Text(
                                          "Forget Password",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
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
                                  GestureDetector(
                                    onTap:
                                        // initiateFacebookLogin,
                                        fbSignIn,
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      margin: EdgeInsets.only(
                                        right: 20,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Color(0xff80808E),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: SvgPicture.asset(
                                        "assets/svg/fb.svg",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: googleSignIn,
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Color(0xff80808E),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: SvgPicture.asset(
                                        "assets/svg/google.svg",
                                        color: Colors.white,
                                      ),
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
                                    "Don't have an accont ?   ",
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
                                              builder: (context) => SignUp()));
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Color(0xffFF5018),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Loading Container
          Container(
              child: _socialLoading
                  ? Loader(loadingTxt: 'Please wait Signing...')
                  : Container())
        ],
      ),
    );
  }

  Widget emailField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffDCDCE0),
      ),
      child: TextFormField(
        onChanged: (value) {
          email = value;
        },
        validator: MultiValidator([
          EmailValidator(errorText: "enter a valid email address"),
          RequiredValidator(errorText: "Required")
        ]),
        cursorColor: Color(0xffff5018),
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          hintText: "Email",
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Icon(
              Icons.email,
              color: Color(0xffFF5018),
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

  Widget passwordField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffDCDCE0),
      ),
      child: TextFormField(
        onChanged: (value) {
          password = value;
        },
        validator: RequiredValidator(errorText: "Required"),
        cursorColor: Color(0xffff5018),
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          hintText: "Password",
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 1),
            child: Icon(
              Icons.lock,
              color: Color(0xffFF5018),
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

  void showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("An Error Occurs"),
              content: Text(message),
              actions: [
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  // Alert Dialog

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
      title: Text(error),
      content: Text(
        "Please Enter correct username and password to continue!",
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
