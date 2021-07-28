import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_door/Api/Home/home_api.dart';
import 'package:social_door/Api/google__api.dart';
import 'package:social_door/Screens/Authentication/Login/login.dart';
import 'package:social_door/Screens/Home/Home%20Widgets/header_home.dart';
import 'package:social_door/Screens/Home/Home%20Widgets/tags_home.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  userLoginFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLogin', false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Column(
          children: [
            header(context),
            HomeTags(),
            ElevatedButton(
                onPressed: () {
                  userLoginFalse();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text("Log Out"))
          ],
        ),
      ),
    );
  }
}
