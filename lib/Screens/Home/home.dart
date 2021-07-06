import 'package:flutter/material.dart';
import 'package:social_door/Api/google__api.dart';

class Home extends StatelessWidget {
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
        child: new Text('This is the Home page'),
      ),
    );
  }
}
