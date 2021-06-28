import 'package:flutter/material.dart';
import 'package:social_door/Screens/Authentication/forget%20password/verifyNumber.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {


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
                  margin: EdgeInsets.only(top: 90,bottom: 60),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width* 0.8,
                  child: Column(
                    children: [
                      Text("Forget Password", style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Enter the phone number associated with",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                      ),),
                      Text(" your account",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white
                        ),),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      inputField("Phone number", Icon(Icons.call)),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: FlatButton(
                          child: Text("Reset password",style: TextStyle(
                              fontSize: 18
                          ),),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder:
                              (context) => VerifyPhonenumber()
                              )
                            );
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
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )
      ),
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
      child: TextField(
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 50),
          labelText: name,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold
          ),
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
            borderSide: BorderSide(color: Color(0xffff5018),width: 3),
          ),
        ),
      ),
    );
  }

}
