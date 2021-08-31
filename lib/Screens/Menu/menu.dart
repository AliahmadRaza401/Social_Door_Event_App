import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_door/Payment/paypalPayment.dart';
import 'package:social_door/Screens/Authentication/Login/login.dart';
import 'package:social_door/Screens/Menu/multiForm.dart';

import 'package:social_door/Screens/create_Event/Image_upload.dart';
import 'package:social_door/Screens/create_Event/createEventStepper.dart';
import 'package:social_door/Screens/create_Event/date_time_piker.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  userLoginFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLogin', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateEventStepper()));
                },
                child: Text("create Event"),
              ),
              ElevatedButton(
                  onPressed: () {
                    userLoginFalse();
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) => Login()));

                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()),
                    );
                  },
                  child: Text("LogOut")),
              ElevatedButton(
                  onPressed: () {
                    userLoginFalse();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DateTimePiker()));
                  },
                  child: Text("Date and Time")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ImageUpload()));
                  },
                  child: Text("Image Picker")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyHomePage(
                              title: 'hy',
                            )));
                  },
                  child: Text("Multi Form")),
            ],
          ),
        ),
      ),
    );
  }
}
