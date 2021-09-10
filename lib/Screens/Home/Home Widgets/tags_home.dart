import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_door/Screens/Home/home_provider.dart';
import 'package:social_door/Screens/OnBoarding/content.dart';

Widget homeTags(context) {
  var tags = HomeProvider().getAllTags(context);
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
    ),
    alignment: Alignment.centerLeft,
    child: FutureBuilder(
      future: tags,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text("Loading..."));
        } else if (snapshot.hasData) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .01,
                    vertical: MediaQuery.of(context).size.height * .01),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .01),
                    height: 10,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * .01,
                      vertical: MediaQuery.of(context).size.width * .01,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(
                              60.0) //                 <--- border radius here
                          ),
                    ),
                    child: Text(snapshot.data[index]['tag_name']),
                  );
                }),
          );
        } else {
          return Center(child: Text("Tags Loading.."));
        }
      },
    ),
  );
}
