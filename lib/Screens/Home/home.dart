import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_door/Api/google__api.dart';
import 'package:social_door/Screens/Authentication/Login/login.dart';

class Home extends StatelessWidget {
  userLoginFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLogin', false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Hello'),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.door_back,
        //       color: Colors.white,
        //     ),
        //     onPressed: () async {
        //       await GoogleApi.logout();
        //     },
        //   )
        // ],
      ),
      body: new Center(
        child: Container(
          child: Column(
            children: [
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
      ),
    );
  }
}
