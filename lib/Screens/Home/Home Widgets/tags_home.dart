import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_door/Api/Home/home_api.dart';

Widget HomeTags() {
  var tags = HomeApi().getAllTags();
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    alignment: Alignment.centerLeft,
    child: FutureBuilder(
      future: tags,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text("No Tags"));
        } else if (snapshot.hasData) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 10,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
