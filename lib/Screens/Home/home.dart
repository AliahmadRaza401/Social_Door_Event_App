import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_door/Api/Home/home_api.dart';
import 'package:social_door/Api/api.dart';
import 'package:social_door/Api/google__api.dart';
import 'package:social_door/Api/postEvent.dart';
import 'package:social_door/Model/createEvent.dart';
import 'package:social_door/Model/getEvents.dart';
import 'package:social_door/Providers/dataProvider.dart';
import 'package:social_door/Screens/Authentication/Login/login.dart';
import 'package:social_door/Screens/Home/Home%20Widgets/header_home.dart';
import 'package:social_door/Screens/Home/Home%20Widgets/postCard.dart';
import 'package:social_door/Screens/Home/Home%20Widgets/tags_home.dart';
import 'package:social_door/Screens/Post_Event/eventPostStepper.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var token;

  @override
  userLoginFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLogin', false);
  }

  usertoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    print('token: $token');
  }

  @override
  void initState() {
    super.initState();
    usertoken();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              header(context),
              homeTags(context),
              PostCard(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventPostStepper()));
                },
                child: Text("create Event"),
              ),
              ElevatedButton(
                  onPressed: () {
                    userLoginFalse();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("Log Out")),
            ],
          ),
        ),
      ),
    );
  }
}
